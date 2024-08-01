Return-Path: <linux-api+bounces-2084-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF851944A88
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2024 13:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C33F1C21120
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2024 11:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD0218EFE0;
	Thu,  1 Aug 2024 11:41:26 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C845118E051;
	Thu,  1 Aug 2024 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722512486; cv=none; b=Rk+CEM5oLQTtte2eC9ERtL9QUcPHyPxJEaSOYB5vVwFy7ai075oVXNh3Y1114jR0WQq+xyyRrTxKxZ1agJMJVSAkgZw5wOMO+wSafchBYwZXYj2zLM96JCy5BRK0UaV7SAm1ECVFbG146VqcnDpYhqYuBYeKFABQOG4Nbj9fhtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722512486; c=relaxed/simple;
	bh=5V1IWwJ8mFdrqsa9mVd5dQqtD1ktzrKKVSVwwuxhxP4=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=MpzeDcfYWxTqP24WxfD5L/XmR+2LpW+k35XEaRetxZC6m4zEY/VpOujsXM4goazVnyDTYhThMeSiPrLmeo4VG2jHMVKbfMyAe8IrOwmjuaxzZkbRG8b94peE4bO85d5L/2HX9/iHt7EUVHs9k1rF3rTEkxMjOPOSMsUdaYynzJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=andypan.me; spf=pass smtp.mailfrom=andypan.me; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=andypan.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andypan.me
X-QQ-GoodBg: 0
X-QQ-SSF: 0000000000000010
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-XMAILINFO: NG8VJ60AcVdMBCNnLfMywZLnDfV6GQmGR8WO1gos/vphpdEGzvssb/uJaAjg43dNq/nh7xGi5WhBiEQIiw37CLNALZ4giNKHVkyUgNfNu71UCK7wk4QsFsOAER7zI5AWjbYEHjv5l4ttncobn4uy8dhJaQv2QOC/ObHG5OV5ZFxWrijde8oTN734V86bYyY8NUIPR5bhoszymcH3EvbvAF4ZS8zCcsBoiAkc3HbTVErs3VTu3GeJxvON/zDex0YVKvI3bwUmn53qIzwtNTwoZ1c1/CzoWD9tA5Hgnq8ZwwEpJkkuFzTIfv+xlrrJ/adNd9U9H3G4/QFrz/6k/jEIXJYqn5qvezlhW+pPwLk/1MPliby7iJbFeag+XQqss1LnC8pfTVil3KXjBZV7aEU822oRlNuU17EIKI4fGZfaTFPjCdGV4q+gmXklfPNonoFhc6BU0HubKTt4ts2kqsVvs1srntFF6RQA5eY54TjQgLbC4UVCt+UJxIGCTJHNmO7lqGhE1P1gtdR40BGw0bOK28Jc8Or7HdHp/Dh8J1dQlGaCBY6gogiLlja5juKzfGvqFszCsRJHrN6y4M5OTpd+QMC1Q5teLa5jtMxfxAKWmlDwg4t4hv+r6pECSSIxiZPANMxFXXHnamjZsgkP1dSZYGgX7KbjhxLObzsDbRpiC4P/P+RUBWTpovWZ4Qy/CVbZRMLryH7cas06Kxme2JiEtPiIxHFi9DQkr7jNvoDUgs9S6dpA+AJ3dd4bZUxwcJxYse2FIVlppyXguhiUekYUpIh7KJTJg3gwLiHj4yB0/7oLkcXjx9I3jkD3PxdY7qJ6W/LcNUPhMKeKRr1gvG+vXCPHTe07RimTWMbIr+lwT7gBkFyMCP99lmg=
X-QQ-FEAT: 3C1WcPM5lQ5eZu+6TmuTtbvlBQypWKHA
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: Ov+r+B511J3Mw9Myl3ypPG4F/oa5+YySRFvSMgty3Is=
X-QQ-STYLE: 
X-QQ-mid: t3sz3a-0t1722512453t7378300
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
Date: Thu, 1 Aug 2024 19:40:52 +0800
X-Priority: 3
Message-ID: <tencent_5324DC14448773D6680DA0A1@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20240730-epoll-et-desc-v3-1-6aa81b1c400d@andypan.me>
	<2yb4zrih5esl3qldowd34ojg7mjq3xqjmqvq5bb5y6ru4x7rv5@p6ahw4ztu5cf>
	<tencent_311E460546C884C26FB32E3C@qq.com>
	<l3suz7pnchnpnd5hhpxk5xqdikdxevp3dsybmhlcmzu6yih66s@zxuvoiunfqwl>
	<DD88B2A8DED5353D+137af5bf-158d-4e1e-b4ae-c4262434f8a6@Spark>
	<l5ezb77kqvbmypsvv4nek7ce46sghrm6ox6zbeq7hzd6j2ouv2@mhaihw3rkwjl>
	<tencent_23435D9572735FC704D2B4B1@qq.com>
In-Reply-To: <tencent_23435D9572735FC704D2B4B1@qq.com>
X-QQ-ReplyHash: 363323956
X-BIZMAIL-ID: 14397034887501294136
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Thu, 01 Aug 2024 19:40:54 +0800 (CST)
Feedback-ID: t:andypan.me:qybglogicsvrgz:qybglogicsvrgz5a-0

VXBkYXRlZCB0byBbUEFUQ0ggdjVdLg0KLS0tLS0tLS0tLS0NCkJlc3QgcmVnYXJkcywNCkFu
ZHkgUGFuDQoNCg0KLS0tLS0tLS0tLS0tLS0tLS0tIE9yaWdpbmFsIC0tLS0tLS0tLS0tLS0t
LS0tLQ0KRnJvbTogICLmvZjlsJEiPGlAYW5keXBhbi5tZT47DQpEYXRlOiAgV2VkLCBKdWwg
MzEsIDIwMjQgMTE6MjIgUE1UbzogICJBbGVqYW5kcm8gQ29sb21hciI8YWx4QGtlcm5lbC5v
cmc+OyANCkNjOiAgIk1pY2hhZWwgS2VycmlzayI8bXRrLm1hbnBhZ2VzQGdtYWlsLmNvbT47
ICJsaW51eC1tYW4iPGxpbnV4LW1hbkB2Z2VyLmtlcm5lbC5vcmc+OyAibGludXgtYXBpIjxs
aW51eC1hcGlAdmdlci5rZXJuZWwub3JnPjsgDQpTdWJqZWN0OiAgUmU6IFtQQVRDSCB2M10g
ZXBvbGwuNzogY2xhcmlmeSB0aGUgZXZlbnQgZGlzdHJpYnV0aW9uIHVuZGVyIGVkZ2UtdHJp
Z2dlcmVkIG1vZGUNCg0KSGkgQWxlamFuZHJvLA0KSSBiZWxpZXZlIEkndmUgZm91bmQgYSBt
b3JlIHN1aXRhYmxlIHBsYWNlIHRvIHB1dCB0aGlzIGFkZGVkIGNsYXJpZmljYXRpb24gc2Vu
dGVuY2UuIFBsZWFzZSBjaGVjayBvdXQgdGhlIFtQQVRDSCB2NF0sIHRoYW5rcyENCi0tLS0t
LS0tLS0tDQpCZXN0IHJlZ2FyZHMsQW5keSBQYW4=


