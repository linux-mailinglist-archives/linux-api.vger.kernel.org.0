Return-Path: <linux-api+bounces-2240-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC6695A957
	for <lists+linux-api@lfdr.de>; Thu, 22 Aug 2024 03:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49EA72836AA
	for <lists+linux-api@lfdr.de>; Thu, 22 Aug 2024 01:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2456FB6;
	Thu, 22 Aug 2024 01:10:26 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F712A933;
	Thu, 22 Aug 2024 01:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289026; cv=none; b=lfvStu9mokqi3nxFOAmOvxSK664hWuDsyE/4BLAzrw84L6xUCjPfX/TDcWLq7QKouCUcpCf1gjr157XNe/Tw+gs9l0lRsWlCQ2YWnyZH1qSDbd2Uy6lK1Zlmo0qposYizC6DF0KfgOfC0ScP+K06eCgUgDJCjWb6ktW/MTUbO0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289026; c=relaxed/simple;
	bh=AJktN86JM2bB2gxNwdyEi8DPDMMsORX140sSEpaRto0=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=njp03X6ZlGXPkDjHrptPDB3cGkE62FY/HHwQefn2WWZPImpMGdIZ5hhHyvkNR1wJKj9vMz0TU+az79o3CxFbms5o8p6Jd73yv0Sh38CgaQfwV46FjQVid4yZIHDIpjX1FgR4hakawXes4KtPXjxl01J7tALNEKHA5WcAgf1BQrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=andypan.me; spf=pass smtp.mailfrom=andypan.me; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=andypan.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andypan.me
X-QQ-GoodBg: 0
X-QQ-SSF: 0000000000000010
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-XMAILINFO: MxdW4jxL6NvXD6fHL120gYbfm76yjsmYLfXpO0z88/xgOld2ErRuJXXW
	thOv4z0NTrKcJTy482VWPLdsDPWzR93inopnbWfvm5m3bm/z5YKyZMt0YSQdmSMVhKIHMcx
	rwDFxuG1SsqqvwPPzNFuTw9NzBbHRCcLmHly0CUb3/Rm8QrEQvhexB7dfFHMe4Akgmfghzv
	af43QnEeDBJCeFnvzUvMQv4FfPmLwHqLO1wombQGTpajojlQQ/Z+TUqrDXTt6n3otIaJ/UO
	lkNNiYJkOkasLjAFbB7/r2iS3XcADsPl924oQPMJeGaTflLByBf7SStuxuQqQQnCjM+ijqQ
	LxWuE0B1RxZVZTY2A5alVrKcHiyqhYlkrvuvLxSFFpBN3hDTMEaliMHXAw9oLclU0AbpP7d
	9pPgc57EROvZvfKtNzaIyP+FPmzYjuf0dNGKomm45G4x1O2cxCUXi/upGJk+cl8xJ/dJWVC
	4joB08wq1fAX/Wb6SSteOWt+3Iw5UqpLrXd/3beh1mv5jWLeGjPR+XxM5RpxAjy4nqMtGRq
	ZK9wb7XXmMowagM5Ovu4Sscw46Q0oy+xA9eLiF9oMU09GTuwyjIIgxj1y/t43EdiRDUbGYD
	huzpam1+PwZylBMJUPaYqWc67/dq+ZdH3zz7kwnyuMzyqFtRcQTPQhRFvqlkF3QuxfLmmIS
	IpfODs1vB5hZLTxtS2pQbSh0xbhZPpx8Yw4lIG5ZmF1tOb2U20jRQb6KBUyTP/OrnbBwLBr
	1Ov6d7bIZzfZxuoeZx2+G4GpJ6s10KCO+uRYvC44AEBQXlSu/a3JldSkyoe8253gEzCXWck
	bi7lDITSIoDIZXzupFGp3Rxp7NgoA==
X-QQ-FEAT: 3C1WcPM5lQ5OGwDMoz4wZ4QxfRDjUqa7
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: UVZSgsRBzq6eE0CxbJW2yj4WfYyIKp3FlJd5zZVy/1o=
X-QQ-STYLE: 
X-QQ-mid: t3sz3a-0t1724288988t108164
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
Date: Thu, 22 Aug 2024 09:09:48 +0800
X-Priority: 3
Message-ID: <tencent_07661819392F7C6A41801501@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20240801-epoll-et-desc-v5-1-7fcb9260a3b2@andypan.me>
	<3d4xkgo7fr6mrlnbcocstjs4ctrh3sutcyrxtgqseiwdjoino5@i3bbqxzii3vx>
	<tencent_45987B697E98024524D8BF8C@qq.com>
	<u2duuhzmc7ht57qwwzsei2p2f6da424pjshyswfmtman3kvmdp@slfra5g3k5q2>
In-Reply-To: <u2duuhzmc7ht57qwwzsei2p2f6da424pjshyswfmtman3kvmdp@slfra5g3k5q2>
X-QQ-ReplyHash: 1024104548
X-BIZMAIL-ID: 1204096202833613912
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Thu, 22 Aug 2024 09:09:49 +0800 (CST)
Feedback-ID: t:andypan.me:qybglogicsvrgz:qybglogicsvrgz5a-0

SGkgQWxlamFuZHJvLA0KR3JhdGlmeWluZyEgQWxzbywgdGhhbmtzIGZvciB5b3VyIGVmZm9y
dHMgaW4gcmV2aWV3aW5nIGFuZCBzdWJtaXR0aW5nIHRoaXMgcGF0Y2ghDQotLS0tLS0tLS0t
LQ0KQmVzdCByZWdhcmRzLA0KQW5keSBQYW4=


