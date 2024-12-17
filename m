Return-Path: <linux-api+bounces-2938-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D1E9F56D8
	for <lists+linux-api@lfdr.de>; Tue, 17 Dec 2024 20:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7EDB1883DF0
	for <lists+linux-api@lfdr.de>; Tue, 17 Dec 2024 19:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447B01F942B;
	Tue, 17 Dec 2024 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="JmVCOpFA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ol0SJg0K"
X-Original-To: linux-api@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F521F9410;
	Tue, 17 Dec 2024 19:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734463490; cv=none; b=oaT98oa2CPuB6G5+2wp44uVrI1YXWyJPlS33z3RkjD026XGuIOiAtthv5heJviAVemhVhY4MevwMsjA7PwH/Tv24W1Ew2VzemyZoE86tOBMHVMXKKhgiJvBVtYLJ0pcitHe5P8YgSwkjwNTbJwrVGjZAsF+kBM8IaT59mZlAQAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734463490; c=relaxed/simple;
	bh=YYiCmxIYKaAHA4tjICmvUHGI9+eNw85lmpRIlH4pHJE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gHiV0qnOuFLPKo3DRDjhuf6+4MjlLEwjlgG9IbB/DxaPJZtgD2ppcYpdI8/6qxadVJ/pXrCUep02wyBe4CvlaZgtok5ORJwuI5b/TpbGxZDk7kkLU/Fnjwm7troXWZTnlIA8ntOePtAABiaG9feqiFOt8l64I3o1CgBzpcIfX1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=JmVCOpFA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ol0SJg0K; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 03C9A114015D;
	Tue, 17 Dec 2024 14:24:45 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 17 Dec 2024 14:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734463485;
	 x=1734549885; bh=EOe6BesmxFnRJHHLU70DJc/y0ejfvE7PEl68vLU8DJs=; b=
	JmVCOpFA5TV440bkBGpJr36N9b+07RrWfSd2L1KaSuCnCucQSMIHXbChJbV0QhsZ
	zaq23FbeQfzXtWZS9m3fm5qRL2S1BrIw9zbkYICrrf07tTyODCCOk2r8ea/AD40a
	x6tgMfz2zEwcVFg3tW1A5FL1XAOQ8EBRJNd1saX1M6pkukmfiyGlzAoRUsalfEA9
	fAj1Zn9fOhxOsV+IJ5EROEE0XpnaNZo64SYqQCnTU2kyCNPSewYXbj0NyKN0DE5x
	/cw7dwNmisqb09fQw/wDmBKCKBCWujTAPy5YhpHoRC/0BbljRc3Pw50GrtRBfRtb
	nKHkAuYXyr7JEQ3Cni20Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734463485; x=
	1734549885; bh=EOe6BesmxFnRJHHLU70DJc/y0ejfvE7PEl68vLU8DJs=; b=o
	l0SJg0KWvLU24ys+FxQtTJdSVAB0SxFfIM21YNXJ6Atp2YMQS0GdqXgA+X5FzXpH
	4/0tXnfrGmM41yYe3mrIftpxxxc2jE2tPDtLFUD1xn+OIrOXjRZeYHYWxbW+sLbh
	BkCopVLOqK26tJgMOu34bPmWeVX886d2V1/R82LOR5Cr3exL0MiIx4ocz0t8PZ/z
	TVxVvv+WXACnKEiogdOBds2yYvP3zgxP94PyXBjwjQy0lWCkO04mfHFEhC65f6c/
	P937IsF3YMLIhY/QTCU5BGEeG8RhljaKIwkXD5m3+VgYC8090Tofj66Nc3oO/QDQ
	CjBB/bM/spxcfOgqJcFLA==
X-ME-Sender: <xms:_M9hZye8_x8F9LN2xBm99bRe-ZB-7pwHzc4tD0QrmKTq_DocoCvLWQ>
    <xme:_M9hZ8NC2PC_Hb7CJjEySXCl8NAUMNzV-UXvq_GxRidhV3YTe67mz_0Zc4jBgy5VG
    4EhdGMqmLoGpDklEAs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleehgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdeg
    jedvfeehtdeggeevheefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsohhnihgtrgguvhgrnhgtvgduse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvggrlhhmvghiugesihhgrghlihgr
    rdgtohhmpdhrtghpthhtohepkhgvrhhnvghlqdguvghvsehighgrlhhirgdrtghomhdprh
    gtphhtthhopeguvhhhrghrthesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehp
    vghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehnrghthhgrnheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggv
    pdhrtghpthhtohepvhhpvghigihothhosehlkhgtrghmphdruggvvhdprhgtphhtthhope
    hmihhnghhosehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:_M9hZzj3M3UwmjgSWr6Gp0u4WL-K3oALGf_WX9s3lbBd5NJP_AZddg>
    <xmx:_M9hZ__-v1OpWFJLY_y1aXkYNeFhm1jaE380ircugowLtG7wqKXcdw>
    <xmx:_M9hZ-twMJmQzUeZ-dOtGax0wDQWfChtzXAr81duPu02MN5m1neD3A>
    <xmx:_M9hZ2HSnSKPTi4gzhZ3qIDE2ADNlox4f_Kg6-LmGulmarfjtKGQBw>
    <xmx:_c9hZ2E_QfgM8Vgzv6LhyCD1PES8KaIJCdTUnaNEiJphrGEGvsPWB0Ki>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C89452220072; Tue, 17 Dec 2024 14:24:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Dec 2024 20:24:23 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Darren Hart" <dvhart@infradead.org>, "Davidlohr Bueso" <dave@stgolabs.net>,
 sonicadvance1@gmail.com
Cc: linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 linux-api@vger.kernel.org, "Nathan Chancellor" <nathan@kernel.org>,
 "Vinicius Peixoto" <vpeixoto@lkcamp.dev>
Message-Id: <94d0e188-10fb-4a4e-b7e0-f308e2f25561@app.fastmail.com>
In-Reply-To: <20241217174958.477692-4-andrealmeid@igalia.com>
References: <20241217174958.477692-1-andrealmeid@igalia.com>
 <20241217174958.477692-4-andrealmeid@igalia.com>
Subject: Re: [PATCH v3 3/3] futex: Wire up set_robust_list2 syscall
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024, at 18:49, Andr=C3=A9 Almeida wrote:
> Wire up the new set_robust_list2 syscall in all available architecture=
s.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  arch/alpha/kernel/syscalls/syscall.tbl      | 1 +
>  arch/arm/tools/syscall.tbl                  | 1 +

Please also change arch/arm64/tools/syscall_32.tbl

     Arnd

