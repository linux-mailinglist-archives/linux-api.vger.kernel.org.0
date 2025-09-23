Return-Path: <linux-api+bounces-4919-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3511AB97E8B
	for <lists+linux-api@lfdr.de>; Wed, 24 Sep 2025 02:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3276F4C0D87
	for <lists+linux-api@lfdr.de>; Wed, 24 Sep 2025 00:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1657B19066B;
	Wed, 24 Sep 2025 00:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b="bf7hJyI9"
X-Original-To: linux-api@vger.kernel.org
Received: from sender4-g3-154.zohomail360.com (sender4-g3-154.zohomail360.com [136.143.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802BE192D8A
	for <linux-api@vger.kernel.org>; Wed, 24 Sep 2025 00:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674104; cv=pass; b=jdWbmmAqjqSHHchCWZH9SN7gwWDzFlrD/GqWGdPln3+uh3CnQPNJ74TpTMaKD4oQO5RzF77zvs56Uj+Qm2cbNaH05ndXumEqQpdYPeVLOhzIAQNbWgTtqSYClaNsTvjg4Vp33NH98nOm0mitfllXssufu1HPtqa51Xnk/GZRLR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674104; c=relaxed/simple;
	bh=obGCkCsqCwg3HfShsHho9gJLfnBU+ZLuOBWHK+OrT+g=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=iLAkpwofkD6KosMCjNVHmJgPgAOaTUsQsIvKeHjQ75jIxG3DPb/ucxYy2NfdxLRhrzmySEHKy2Lr81d6Kp9j6tEhK1kBCZ/cx/4Bm27kfpc72URzlFYZwf6U6BFIEU85D21fx0tLO6XymnlcJH5TdM3Jx/tS8eHJ6MpIyKH7PTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx; dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b=bf7hJyI9; arc=pass smtp.client-ip=136.143.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx
ARC-Seal: i=1; a=rsa-sha256; t=1758674101; cv=none; 
	d=us.zohomail360.com; s=zohoarc; 
	b=eMpENaQFhHqsgLch7OMQDXIkrtL41cQPCFq5p6eafLQKL6dIgC+ritlnlf7Y0SXUa/9UMxKo0tUo8yHvkL8Z0zJwgPiqc0cIhy1BLeenHBCzs5WqN2PiKhA3E/xmoYNCHLZe9M0NgudCxycZBvSxu2DkIbgU5OPXxJnDEzSIa68=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=us.zohomail360.com; s=zohoarc; 
	t=1758674101; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=obGCkCsqCwg3HfShsHho9gJLfnBU+ZLuOBWHK+OrT+g=; 
	b=DGmpXXCrYE58cBUhlEij7YD2AdxYE96kInnFqEmzwcxl5c+uZHCABaaR+hMQSrBbxsZVTmXKyaGZt4FgtdouDOiCfZczvIpVRneGfZL8RRg7Vk+R5sLOP58z7Hq9JhNyALhULB4khqzj/NyCVdxJHP30l0s2zWkIUQRSdFzPLYw=
ARC-Authentication-Results: i=1; mx.us.zohomail360.com;
	dkim=pass  header.i=maguitec.com.mx;
	spf=pass  smtp.mailfrom=investorrelations+9a5b54c0-98d8-11f0-9ce0-52540088df93_vt1@bounce-zem.maguitec.com.mx;
	dmarc=pass header.from=<investorrelations@maguitec.com.mx>
Received: by mx.zohomail.com with SMTPS id 1758671653533637.8814331612847;
	Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=bf7hJyI9nbNv/NEOTBmT9SVIRobwZ+19iw+jCXLfBTPSP++pSMr+SaX9W8cCb5H+sjDWblv7uxT/BhhKSC+5vyeLiVE1g7jcHzMN7nOrLipTMcs+9gs+kuPCPgyaM/LK8zQsc12CPozmOXDM8aC118gGVhpLg4eTieHChTdr8zw=; c=relaxed/relaxed; s=15205840; d=maguitec.com.mx; v=1; bh=obGCkCsqCwg3HfShsHho9gJLfnBU+ZLuOBWHK+OrT+g=; h=date:from:reply-to:to:message-id:subject:mime-version:content-type:content-transfer-encoding:date:from:reply-to:to:message-id:subject;
Date: Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
From: Al Sayyid Sultan <investorrelations@maguitec.com.mx>
Reply-To: investorrelations@alhaitham-investment.ae
To: linux-api@vger.kernel.org
Message-ID: <2d6f.1aedd99b146bc1ac.m1.9a5b54c0-98d8-11f0-9ce0-52540088df93.19978ffc40c@bounce-zem.maguitec.com.mx>
Subject: Thematic Funds Letter Of Intent
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
content-transfer-encoding-Orig: quoted-printable
content-type-Orig: text/plain;\r\n\tcharset="utf-8"
Original-Envelope-Id: 2d6f.1aedd99b146bc1ac.m1.9a5b54c0-98d8-11f0-9ce0-52540088df93.19978ffc40c
X-JID: 2d6f.1aedd99b146bc1ac.s1.9a5b54c0-98d8-11f0-9ce0-52540088df93.19978ffc40c
TM-MAIL-JID: 2d6f.1aedd99b146bc1ac.m1.9a5b54c0-98d8-11f0-9ce0-52540088df93.19978ffc40c
X-App-Message-ID: 2d6f.1aedd99b146bc1ac.m1.9a5b54c0-98d8-11f0-9ce0-52540088df93.19978ffc40c
X-Report-Abuse: <abuse+2d6f.1aedd99b146bc1ac.m1.9a5b54c0-98d8-11f0-9ce0-52540088df93.19978ffc40c@zeptomail.com>
X-ZohoMailClient: External

To: linux-api@vger.kernel.org
Date: 24-09-2025
Thematic Funds Letter Of Intent

It's a pleasure to connect with you

Having been referred to your investment by my team, we would be=20
honored to review your available investment projects for onward=20
referral to my principal investors who can allocate capital for=20
the financing of it.

kindly advise at your convenience

Best Regards,

Respectfully,
Al Sayyid Sultan Yarub Al Busaidi
Director

