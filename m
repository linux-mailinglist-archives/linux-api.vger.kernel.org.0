Return-Path: <linux-api+bounces-2106-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 995C5946A06
	for <lists+linux-api@lfdr.de>; Sat,  3 Aug 2024 16:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58526281DC2
	for <lists+linux-api@lfdr.de>; Sat,  3 Aug 2024 14:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41987B641;
	Sat,  3 Aug 2024 14:15:50 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04F5C8F3;
	Sat,  3 Aug 2024 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722694550; cv=none; b=n5WjZvV3cWpXYj4UaIIUJ0OoYc7CS436UI6+w33Tqw2avAVQCu60At7h1MpTC6TsKTnl+lesxS7O087aWVZZT5e4jadSUTIWNjZEyO7BeNcPy/E96uDpbe7J5pykD08u3vA/UkzcPdUSJ5lC0ep0QWoRxsAfVolACu4kXUbXzdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722694550; c=relaxed/simple;
	bh=dIACq+KdJahpWYQZD71WdpMc1D/497p1PJwmHl7RwJM=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=aEDiCkU+M4Ci4kPMU7N+UxSeVfhUEuvw/vMgY4hDsGrhwv8TXs/lF2jfSssc6r9u8r2OIRXfKvmdStUoKk3IJMYR8Nx2MJfkXXYk8k5ifnfROx59JiwhOndcRDvyN1oS0Hdyx2O7/6tNF6uH0Tp3cDCHJiE+7Mbc0o2bGdrmEgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=andypan.me; spf=pass smtp.mailfrom=andypan.me; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=andypan.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andypan.me
X-QQ-GoodBg: 0
X-QQ-SSF: 0000000000000010
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-XMAILINFO: NVKp1b6YP/YcjpkZKwx5jTn2CPzIC+pCGJ9h/xnPNJ54o25yHbEvEENXvB+yeQ+qdGvdW0qL+fXwAAirbXrTxLZDsC1xqtLi7SBoJq+u62WwQers1NpJeSd2FGqDLEFjVhZt8XTPO4u00tV6P5j68gz/Co0e4tNRiyg52fWMKPdNmdhGm+1qXnpRCtxgtmaO/0BU3HBBbEMkOuF3zFsCbVQIpZZCgfsIixhn1vqkMdhaQ5SDRX6i+3NRschSig8IU1InwhTrf7mWTfDfuw/r2JHj06t5YP7wjy9aFqsojUCEZdhEcXXRlKeX3/6DiTf8REEqbRZV63s5XqBaLdwaE3N8h4bLoHU+FmeO09o4dWMNvcEMTJORXC8O60P+GjI8RWW4PR+zzGY7QAvuZWXN8Ru/XkpKqpUyAgvaCB9Lp1vc/FOAAJx8GXNUkWk267V45QG0eDTBKkqumuYnDnXrzBC+drkv5wEsP+R4myW02gi3o3D1iTQY0whsKZqjuXWheiLkJT7xxebwXzZzxm54qHrbU9rCQQAF3wHckddbX74wa/VCb1Vr15TK8xKnG0qfB2Vkyc11sWVS7TWQR+SwJPOcd+GdziuLQ8cnU6yPSsvYzQtF5eqDd5w0Buj8g2GSnBmlzmIdXHKRrTCy7b+t9+p25+W+Bt7RUyNMqaof/kPrqp0w2qHqnAGKvqiLdQsqzxIIzt7pKQuWvTZ/yESDS6fQrYki6yu2kXS7T4oxHxkB4+9CHTBRfJZMyBQdE2Fe6dEXvE+Oc40omNq+DZ0PZfFivRTVyGve9zLQr0SSvZo2nlWMtcipWswqf7kzRmEx7Rpg9VyFOMSIU2eiDvVMmoJZKIyzqYhfHJJS4w/TuISSPTmjNOSNby0=
X-QQ-FEAT: 3C1WcPM5lQ5eZu+6TmuTtbvlBQypWKHA
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: HJApUCXEdM5ZNK2w50nX59w87MxBuXMHL6R0roqdEVQ=
X-QQ-STYLE: 
X-QQ-mid: t3sz3a-0t1722694510t6053571
From: "=?utf-8?B?5r2Y5bCR?=" <i@andypan.me>
To: "=?utf-8?B?QWxlamFuZHJvIENvbG9tYXI=?=" <alx@kernel.org>
Cc: "=?utf-8?B?bGludXgtbWFu?=" <linux-man@vger.kernel.org>, "=?utf-8?B?bGludXgtYXBp?=" <linux-api@vger.kernel.org>, "=?utf-8?B?TWljaGFlbCBLZXJyaXNr?=" <mtk.manpages@gmail.com>, "=?utf-8?B?cGFuamYyMDAw?=" <panjf2000@gmail.com>
Subject: Re: [PATCH v5] epoll.7: clarify the event distribution under edge-triggered mode
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 3 Aug 2024 22:15:10 +0800
X-Priority: 3
Message-ID: <tencent_45987B697E98024524D8BF8C@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20240801-epoll-et-desc-v5-1-7fcb9260a3b2@andypan.me>
	<3d4xkgo7fr6mrlnbcocstjs4ctrh3sutcyrxtgqseiwdjoino5@i3bbqxzii3vx>
In-Reply-To: <3d4xkgo7fr6mrlnbcocstjs4ctrh3sutcyrxtgqseiwdjoino5@i3bbqxzii3vx>
X-QQ-ReplyHash: 4209173068
X-BIZMAIL-ID: 10863523324054820480
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Sat, 03 Aug 2024 22:15:11 +0800 (CST)
Feedback-ID: t:andypan.me:qybglogicsvrgz:qybglogicsvrgz5a-0

VGhhbmsgeW91IGZvciB0aGUgdXBkYXRlcyENClBsZWFzZSBhbHNvIHVwZGF0ZSB0aGlzIGVt
YWlsIHRocmVhZCBhZnRlciBtZXJnaW5nIHRoaXMgcGF0Y2gsIHRoYW5rcyBpbiBhZHZhbmNl
Lg0KDQpTb3JyeSBhZ2FpbiBmb3IgaW50ZXJydXB0aW5nIHlvdXIgd2Vla2VuZC4gSGF2ZSBh
IGdyZWF0IHdlZWtlbmQhDQotLS0tLS0tLS0tLQ0KQmVzdCByZWdhcmRzLA0KQW5keSBQYW4=


