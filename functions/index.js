const functions = require("firebase-functions");
const nodemailer = require("nodemailer");

const mailer = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "YOUR_GMAIL@gmail.com",
    pass: "APP_PASSWORD",
  },
});

exports.sendOtpEmail = functions
    .region("asia-southeast1")
    .https.onCall(async (data) => {
      const {email, code} = data;

      await mailer.sendMail({
        from: "Stroke Predictor <no-reply@strokepredictor.app>",
        to: email,
        subject: "Mã xác nhận đăng ký",
        text: "Mã xác nhận của bạn là: " + code,
      });

      return {ok: true};
    });
