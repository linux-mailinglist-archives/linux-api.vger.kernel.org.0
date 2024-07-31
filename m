Return-Path: <linux-api+bounces-2073-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BA8943321
	for <lists+linux-api@lfdr.de>; Wed, 31 Jul 2024 17:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016201C2432E
	for <lists+linux-api@lfdr.de>; Wed, 31 Jul 2024 15:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCC21BC089;
	Wed, 31 Jul 2024 15:22:51 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7DB12B73;
	Wed, 31 Jul 2024 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.65.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722439370; cv=none; b=mRlAby6eTu+xWdMv746WP9M6+Q9NGnd1/0OLIQCC2lcCmaXSqtfUI9dM9cMEqXndQndMqnVznePu4FNsUaUOWdqJOhShLwY916amUY+axaIpwb9nYwFzuNA3jDAF98ffd7BSfy55p6AzQDD29bdwXRJqffk0W+SKykbV06GskR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722439370; c=relaxed/simple;
	bh=97ZLzQpF4Hfqofg6YA2ErCs+/A9HhZNWmNNEqNHjG34=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=itcMY3OFQtugQUnhFySled6utA323g/QkvM8267njppgRss4dg8PQUq9Va60kBmUVB0GLt1qL/O4uowCCcfcw7Wf4t9JAwUtDE/v8zW8mNQecd+Z81sOKOs6wwvAG9HtAvbFpQKiP5mwYmLwithctwIqTeVsZKWKi6aLwsxYj/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=andypan.me; spf=pass smtp.mailfrom=andypan.me; arc=none smtp.client-ip=43.155.65.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=andypan.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andypan.me
X-QQ-GoodBg: 0
X-QQ-SSF: 0000000000000010
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-FEAT: FwowAM4HOqCrqOq7iTmpVZfa2m7qNeh9E1ine1LMDKbsn3BgMigZS511emphS
	1kOuDY6Lz/RMyMtXQcgFJez1m4ZzIZPhIx59K9C10wzHvRcOA8GdihAZtVK/XLHcmG9trMq
	tI32VaMEhLDx480jCjdgXKCCLkLMFYEgk/ugJsrenNM8w8V1p7HHoDrDfBWO3tIoGWMqH30
	9fTMJU7h9zV5FB8BbKZ9a4LiI8n76LphYSGOs876wc0GXNg8Bp+81m3Fm4HDs6gyopr8WZt
	okwgjHcTUQxCO+fJZkaUgDh/mq4WJPCLRgqxiw1HWVrv0gt7EHY8gsQK9YxeXxWHj0X+pVz
	40lRd/VUyTicTbWM9WoQg8c+OlUNA==
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: Voj2I92PkidtzOcCLeDtZH2QtxZ/KFsPH0ptUZpFIRI=
X-QQ-STYLE: 
X-QQ-mid: t3sz3a-0t1722439349t5476374
From: "=?utf-8?B?5r2Y5bCR?=" <i@andypan.me>
To: "=?utf-8?B?QWxlamFuZHJvIENvbG9tYXI=?=" <alx@kernel.org>
Cc: "=?utf-8?B?TWljaGFlbCBLZXJyaXNr?=" <mtk.manpages@gmail.com>, "=?utf-8?B?bGludXgtbWFu?=" <linux-man@vger.kernel.org>, "=?utf-8?B?bGludXgtYXBp?=" <linux-api@vger.kernel.org>
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
Date: Wed, 31 Jul 2024 23:22:29 +0800
X-Priority: 1
Message-ID: <tencent_23435D9572735FC704D2B4B1@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20240730-epoll-et-desc-v3-1-6aa81b1c400d@andypan.me>
	<2yb4zrih5esl3qldowd34ojg7mjq3xqjmqvq5bb5y6ru4x7rv5@p6ahw4ztu5cf>
	<tencent_311E460546C884C26FB32E3C@qq.com>
	<l3suz7pnchnpnd5hhpxk5xqdikdxevp3dsybmhlcmzu6yih66s@zxuvoiunfqwl>
	<DD88B2A8DED5353D+137af5bf-158d-4e1e-b4ae-c4262434f8a6@Spark>
	<l5ezb77kqvbmypsvv4nek7ce46sghrm6ox6zbeq7hzd6j2ouv2@mhaihw3rkwjl>
In-Reply-To: <l5ezb77kqvbmypsvv4nek7ce46sghrm6ox6zbeq7hzd6j2ouv2@mhaihw3rkwjl>
X-QQ-ReplyHash: 239215721
X-BIZMAIL-ID: 942928434929424878
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Wed, 31 Jul 2024 23:22:31 +0800 (CST)
Feedback-ID: t:andypan.me:qybglogicsvrgz:qybglogicsvrgz5a-0

SGkgQWxlamFuZHJvLA0KSSBiZWxpZXZlIEkndmUgZm91bmQgYSBtb3JlIHN1aXRhYmxlIHBs
YWNlIHRvIHB1dCB0aGlzIGFkZGVkIGNsYXJpZmljYXRpb24gc2VudGVuY2UuIFBsZWFzZSBj
aGVjayBvdXQgdGhlIFtQQVRDSCB2NF0sIHRoYW5rcyENCg0KLS0tLS0tLS0tLS0NCg0KQmVz
dCByZWdhcmRzLA0KQW5keSBQYW4=


