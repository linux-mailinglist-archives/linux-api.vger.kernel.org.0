Return-Path: <linux-api+bounces-2104-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5596694698A
	for <lists+linux-api@lfdr.de>; Sat,  3 Aug 2024 13:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C4B01C20B0B
	for <lists+linux-api@lfdr.de>; Sat,  3 Aug 2024 11:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A95C14BF8B;
	Sat,  3 Aug 2024 11:50:35 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8121396;
	Sat,  3 Aug 2024 11:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722685835; cv=none; b=rPvtFVn79aQdjx+t4XXavjwZ6L79ITCPm4x8+83yaND3IDsBCBq7UZz9s+AicgUhQ2bOvMfzvPbk0cITGAk7XZLlayaV2CeJq4uBacdCaY83xprl79WY84SgVG0dceKlEJ5BHxVnxGjHzGe3j3TiTzm1yURNUx9NeNDyZQDV/Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722685835; c=relaxed/simple;
	bh=lo+SMrHeEEwNKK8T12ua3eiCGkIrfBtggSOB2P23vLY=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=Ncp/WA9iD5B9NbzLYery0/Z30Rnc44ZW7ohvx8ElpPXjJ0/0mGpeUVvPTW+MgSx9X02pMHKwzM4iGYuv4Go6EJB7Rcx9PVPIPtGE9qaEc7fCRZvvyd6EC5Lgjjf1Fz7WzWppznc/vjFMwuHe8OuJQ9pFiDv6BpgcRiR9Af8+YOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=andypan.me; spf=pass smtp.mailfrom=andypan.me; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=andypan.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andypan.me
X-QQ-GoodBg: 0
X-QQ-SSF: 0000000000000010
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-XMAILINFO: M4Fzb0/LdfyYoHzf5chci+UnfFqeucAURoNNbBk6yWpxzeu5tIKTpM4Zb23KmgSagDF/af4KSUbiYqiq9PS8GKYOqnBjGLQan8HIk27Pbr3vRwgfqHpko3XClqOgctYqYS18aL3gE+Egg5YQR0NMezsyR43f+xjBxgoAnS46hwwn9pxAE5fBtwl5YHAvbcGoqUyIc6dtfjjWlFYkgzK21Eqynv0dH+VvKojg8c4T2OtX2Q3eKAyy9+8W8Eyvca93Ee+3GplsYfdjg/WxW4+L4a+ihDweZNPgG6aLcIR4KLyYNcf84HmCWyA+AdHWtb5SkCNdXT0iLDAtEQ/vBvcbO7mB0mhadAvmN+bdFvWhJxqr8aSdSBFR+OODfvrEnaLuTcpPTZkA1AnuB8sUSTZyX43KGc4iABzJgEjYAVfNIWKxGAwWH+3lmxraGfuG9MlAQ441w05G8epdwfiV82NzhON2wYIwg86luJfxp0pFVZfW9uv0QXRFrjeH74eEO0bmtBdvww0E9q1BXt9V5tiPNkCqy3WW7BaATZ/OsVexJs+BTghinGLI8A3Wwf9Bc5Q/aICMMozPrl/5ei9NYkXZG7o81zl8ggdBULgePVdSEA4R+OJKmXAyvJgFwlDxCoz9uNfxuttx3Hd/NZxYAfUkBaaYF50nhy+wtoD0LdagmDpDvJSaCWuRfuF1m78VZjBgG83Y3pkaSkzGQyx+d9mmwGt+OYoWWcMEq4DgFhZEX06j1w7KV8L/397IQ65DHKS2RzU/QDyF8ZBMo56hAqPhDnyhIE93Ao2SJK//Q3dT/tIJrXV34Om2RtInne5evUJmwbqf2MMgY3iKF1kQvRx0ouCMLmm5xDbvbg==
X-QQ-FEAT: 3C1WcPM5lQ5eZu+6TmuTtbvlBQypWKHA
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: sllIw50gWwRmZhX7x56TwkX9HoG0tmrReVRZsnxsN+Y=
X-QQ-STYLE: 
X-QQ-mid: t3sz3a-0t1722685786t1279607
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
Date: Sat, 3 Aug 2024 19:49:46 +0800
X-Priority: 3
Message-ID: <tencent_3AE43AE7086899C208E85D79@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20240801-epoll-et-desc-v5-1-7fcb9260a3b2@andypan.me>
	<4zemhoksplppb35pvpm7cahmaar45hhn3s7tne5pqbgx5bmtg5@jj6hz5yetm4z>
In-Reply-To: <4zemhoksplppb35pvpm7cahmaar45hhn3s7tne5pqbgx5bmtg5@jj6hz5yetm4z>
X-QQ-ReplyHash: 4294063989
X-BIZMAIL-ID: 5285462311936710065
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Sat, 03 Aug 2024 19:49:47 +0800 (CST)
Feedback-ID: t:andypan.me:qybglogicsvrgz:qybglogicsvrgz5a-0

SGkgQWxlamFuZHJvLA0KU29ycnkgdG8gYm90aGVyIHlvdSBvdmVyIHRoZSB3ZWVrZW5kLCBi
dXQgSSBoYXZlbid0IHNlZW4gdGhlIHBhdGNoIHN1Ym1pdHRlZCB5ZXQuDQpJcyB0aGVyZSBz
b21ldGhpbmcgd3Jvbmcgd2l0aCBpdD8NCi0tLS0tLS0tLS0tDQpCZXN0IHJlZ2FyZHMsDQpB
bmR5IFBhbg==


