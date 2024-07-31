Return-Path: <linux-api+bounces-2061-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 199E2942D2D
	for <lists+linux-api@lfdr.de>; Wed, 31 Jul 2024 13:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6E93B21876
	for <lists+linux-api@lfdr.de>; Wed, 31 Jul 2024 11:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C151AC436;
	Wed, 31 Jul 2024 11:22:10 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DD6200CD;
	Wed, 31 Jul 2024 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.54.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722424930; cv=none; b=tyVfCGmwTnXRb9mbRbEmPBXRWRwNJKhMwwNynwfpx/lrKx4XXPXZVcIrGxKVBpfCg4fF4GnktjY/z7BXSdMPVrFT6seUPML7tAHqlFBK/I6klpcNPyYzaDMrLkxdngxoac+iaKiSOp5u8sJ/M+5sFbcKkaFBwiKgLPddseAbh7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722424930; c=relaxed/simple;
	bh=hfbybpF8H0+Sw3EeXWNIXq1L9F3SjeSj4N2aPH3oQJg=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=gcePsT54nBNEoZDKQqD3Oy/xbmFWSkHyNUJc33MmgUgN0JOxFMzt7AEbSkpGfLrftqoGX5nsIOsjuHT0phV30FjbrXNchRWzc65IiCbhUootSM25Ycb9c5axxPHagXRWJrSyZWERaiOYKPAXp+WvchwFzxs8G/TFlyDliFviykU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=andypan.me; spf=pass smtp.mailfrom=andypan.me; arc=none smtp.client-ip=43.154.54.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=andypan.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andypan.me
X-QQ-GoodBg: 0
X-QQ-SSF: 0000000000000010
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-FEAT: vYsbhmc1Ekqv7fkGehb27avMu8tNEzL3MKsqskFurXGlFBEdmRSUnGkPWFtTg
	kkYs/R1G22mRpV1wnzQZZMRvhZrA2e5XG223ddi/n2Z2O6GINAchBVeCcQR7pjDjOTDLXga
	TJ2K21yM3cKwLRfgUBc5XayrNLpgGh5Zi4xIRqEZeyIQETPHboj+1GJcW4fO341MbuKleXQ
	q1W3kNJWd32u+FPA5K6c5euG1+zqPHUyWyn1qVAvzWGwhAVwWlgdsxp1xbbi2z3I+gnCVMP
	PBr/sISFC9qBI4hzQjWQtNJ8i5b7a6nB38gfQpannGSL7HEXmbHcT8EWRiZAEbX9ccrz64r
	hn/tM/WER103Ei/1gu8w62UA9se1w==
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: /+Rsc3Pvr+EMWHfvfN4cF/bGxvaD+gcSy0yeGCBI5ZY=
X-QQ-STYLE: 
X-QQ-mid: t3sz3a-0t1722424914t953791
From: "=?utf-8?B?5r2Y5bCR?=" <i@andypan.me>
To: "=?utf-8?B?QWxlamFuZHJvIENvbG9tYXI=?=" <alx@kernel.org>, "=?utf-8?B?TWljaGFlbCBLZXJyaXNr?=" <mtk.manpages@gmail.com>
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
Date: Wed, 31 Jul 2024 19:21:53 +0800
X-Priority: 3
Message-ID: <tencent_2C1C81293D63F2F94CFAFABD@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20240730-epoll-et-desc-v3-1-6aa81b1c400d@andypan.me>
	<2yb4zrih5esl3qldowd34ojg7mjq3xqjmqvq5bb5y6ru4x7rv5@p6ahw4ztu5cf>
	<tencent_311E460546C884C26FB32E3C@qq.com>
	<l3suz7pnchnpnd5hhpxk5xqdikdxevp3dsybmhlcmzu6yih66s@zxuvoiunfqwl>
In-Reply-To: <l3suz7pnchnpnd5hhpxk5xqdikdxevp3dsybmhlcmzu6yih66s@zxuvoiunfqwl>
X-QQ-ReplyHash: 2527672797
X-BIZMAIL-ID: 11311877155600138012
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Wed, 31 Jul 2024 19:21:56 +0800 (CST)
Feedback-ID: t:andypan.me:qybglogicsvrgz:qybglogicsvrgz5a-0

T0ssIEkgZ2V0IHlvdXIgcG9pbnQgbm93LiBJbiB0aGF0IGNhc2UsIHNob3VsZCBJIHN0YXJ0
IGEgbmV3IHBhcmFncmFwaCB3aGVyZSBJIHB1dCB0aGUgY2xhcmlmaWNhdGlvbj8gSWYgc28s
IHdoZXJlIHdvdWxkIHlvdSBzdWdnZXN0IEkgYmVnaW4gd3JpdGluZyB0aGF0IG5ldyBwYXJh
Z3JhcGg/IFRoYW5rcyEgKFNvcnJ5IGZvciB0aGUgZHVwbGljYXRlIGVtYWlsIGlmIHlvdSd2
ZSBhbHJlYWR5IGdvdCBteSBsYXN0IG9uZSwgaXQgZ290IHJlamVjdGVkIGJ5IHRoZSBlbWFp
bCBnb3VycHMgb2YgbGludXgtbWFuIGFuZCBsaW51eC1hcGkgZHVlIHRvIEhUTUwgY29udGVu
dCBpbiB0aGF0IGVtYWlsLCBzbyBJJ20gc2VuZGluZyBpdCBhZ2FpbiB3aXRoIG9ubHkgcGxh
aW4gdGV4dC4pDQoNCkJlc3QgcmVnYXJkcywNCkFuZHkgUGFu


