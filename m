Return-Path: <linux-api+bounces-2058-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0751D942C97
	for <lists+linux-api@lfdr.de>; Wed, 31 Jul 2024 12:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B02F1F25F8A
	for <lists+linux-api@lfdr.de>; Wed, 31 Jul 2024 10:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F4D1AC42F;
	Wed, 31 Jul 2024 10:55:21 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2527E0E4;
	Wed, 31 Jul 2024 10:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.54.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423321; cv=none; b=kHhMoEDN8bdX9+RxTQKAXTiceIbwYsOWIS5eEgg2Zge55/+vShNcfjsoQ8LqVE1LlPKNZRor/z4IoWdvUwCkHfpserKBUffgdJc/wBQNPjbR6ZnhGvSoQnNFWJvMgUKv1BshhCiTLivUo7E2A+PH3rpYqdtRPPkwj+ce6dA4KSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423321; c=relaxed/simple;
	bh=OnAGybKe6Km5r0FBv+3wx+CbsPEG5bWrM9GMjtTC1pM=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=DwQdWu+SA7qNE1Xojq0AtQD/vMTE/Xbm/SR/HlvPL6rS4i5WGgBR0TFj6TXjDtOK2Uf7uommYF7WKDb9B7AV9InmAyGCI/HYaPpqxO46+HGHZolxexcgNKGzIHEtKXNJ7YIQYWQSH8SUF/CBG8/BL5kIwugHPNEkoZLYe6yNE1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=andypan.me; spf=pass smtp.mailfrom=andypan.me; arc=none smtp.client-ip=43.154.54.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=andypan.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andypan.me
X-QQ-GoodBg: 0
X-QQ-SSF: 0000000000000010
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-FEAT: w7IG6bg2XpkwAvyP+6O77mB7NovnGKExxiG7tWrkZbM2Yo8kGk47uZSg7KFxu
	roEbUdwmLeJHQTnvKRRjTCLDMKQbRsdyhojyXh8EVw9vXDkdnrbTZogh7erz3/2ndbAq4GO
	kH/K9nN3ElROml7+EcIynX0hgGYScHyPqQKPddO6BdWrsjAhahXiznQsqRKSptWrciGJiyq
	Vrt4dt4i6g4Vw7cNuxgM8XoRGup8NZoaoMwkluPSH3FCCSl950wmg3p4ZB+tadJxQ7cMZxT
	Ac1FWM3CpBii0dweq2ThxJ+9kZGQTBDena/pzGWQHoOk71vTpTW9mSNoIJ49wEV+iHkqB8n
	S6t87zplbeDXtvMTcd/Npstg1x0pQ==
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: m1/2UpAZXbr2imwOK+WcxZAG7NRv9aOWLKt1FBG0nyI=
X-QQ-STYLE: 
X-QQ-mid: t3sz3a-0t1722423266t8278338
From: "=?utf-8?B?5r2Y5bCR?=" <i@andypan.me>
To: "=?utf-8?B?QWxlamFuZHJvIENvbG9tYXI=?=" <alx@kernel.org>
Cc: "=?utf-8?B?bGludXgtbWFu?=" <linux-man@vger.kernel.org>, "=?utf-8?B?bGludXgtYXBp?=" <linux-api@vger.kernel.org>
Subject: Re: [PATCH v3] epoll.7: clarify the event distribution under edge-triggered mode
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Wed, 31 Jul 2024 18:54:26 +0800
X-Priority: 3
Message-ID: <tencent_311E460546C884C26FB32E3C@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20240730-epoll-et-desc-v3-1-6aa81b1c400d@andypan.me>
	<2yb4zrih5esl3qldowd34ojg7mjq3xqjmqvq5bb5y6ru4x7rv5@p6ahw4ztu5cf>
In-Reply-To: <2yb4zrih5esl3qldowd34ojg7mjq3xqjmqvq5bb5y6ru4x7rv5@p6ahw4ztu5cf>
X-QQ-ReplyHash: 422778092
X-BIZMAIL-ID: 12358250624617586683
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Wed, 31 Jul 2024 18:54:28 +0800 (CST)
Feedback-ID: t:andypan.me:qybglogicsvrgz:qybglogicsvrgz5a-0

SGkgQWxlamFuZHJvLA0KPiBTaW5jZSBldmVuIHdpdGggZWRnZS10cmlnZ2VyZWQgZXBvbGws
IG11bHRpcGxlIGV2ZW50cyBjYW4gYmUNCj4gZ2VuZXJhdGVkIHVwb24gcmVjZWlwdCBvZiBt
dWx0aXBsZSBjaHVua3Mgb2YgZGF0YSwgdGhlIGNhbGxlciBoYXMNCj4gdGhlIG9wdGlvbiB0
byBzcGVjaWZ5IHRoZSBFUE9MTE9ORVNIT1QgZmxhZywgdG8gdGVsbCBlcG9sbCB0bw0KPiBk
aXNhYmxlIHRoZSBhc3NvY2lhdGVkIGZpbGUgZGVzY3JpcHRvciBhZnRlciB0aGUgcmVjZWlw
dCBvZiBhbg0KPiBldmVudCB3aXRoIGVwb2xsX3dhaXQoMikuICBXaGVuIHRoZSBFUE9MTE9O
RVNIT1QgZmxhZyBpcw0KPiBzcGVjaWZpZWQsIGl0IGlzIHRoZSBjYWxsZXIncyByZXNwb25z
aWJpbGl0eSB0byByZWFybSB0aGUgZmlsZQ0KPiBkZXNjcmlwdG9yIHVzaW5nIGVwb2xsX2N0
bCgyKSB3aXRoIEVQT0xMX0NUTF9NT0QuDQoNClRoaXMgcGFyYWdyYXBoIGluIG1hbiBwYWdl
cyBvZiBlcG9sbCBzdGFydHMgd2l0aCAiU2luY2UgZXZlbiB3aXRoIGVkZ2UtdHJpZ2dlcmVk
IGVwb2xsIiwgdGh1cyBJIGFzc3VtZSB0aGUgZm9sbG93aW5nIHNlbnRlbmNlcyBvZiAibXVs
dGlwbGUgZXZlbnRzIGNhbiBiZSBnZW5lcmF0ZWQgdXBvbiByZWNlaXB0IG9mIG11bHRpcGxl
IGNodW5rcyBvZiBkYXRhIiBhbmQgInRoYXQgaXMsIGFuIGV2ZW50IHdpbGwgYmUgZ2VuZXJh
dGVkIHVwb24gZWFjaCByZWNlaXB0IG9mIGEgY2h1bmsgb2YgZGF0YSIgb3VnaHQgdG8gYmUg
dGFsa2luZyBhYm91dCBFUE9MTEVUIG5hdHVyYWxseS4gSGF2ZSBJIG1pc3VuZGVyc3Rvb2Qg
c29tZXRoaW5nPw==


