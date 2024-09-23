Return-Path: <linux-api+bounces-2325-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CDB983939
	for <lists+linux-api@lfdr.de>; Mon, 23 Sep 2024 23:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422731C21837
	for <lists+linux-api@lfdr.de>; Mon, 23 Sep 2024 21:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A97583A09;
	Mon, 23 Sep 2024 21:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="HZvEt5IP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LTdAPKi9"
X-Original-To: linux-api@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244D980603;
	Mon, 23 Sep 2024 21:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727128240; cv=none; b=cxw6JvF+b4INFSlMNrY9rQ0e7QEJKLjGzyXJ1R2p+3yLAfH98lcynTHXb2Oj44cSIGrR5dVdM7E1DVENjHQ3I/VJNMsGjmtCZf9if/kHqmExcGj4XiZcnDucj8TSG1G6Z485U/eoAPmTuyC/H1d+hKz+xQNG1WgRFcf+0P3bXHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727128240; c=relaxed/simple;
	bh=jGoUda1eMDnVP6rY2rx+0rdFBSl5UCMK+VNb5V/HWbQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mg3mbaWk2vSb8qhUznUSCbva/6j4k0JIpBciwbvn5mKifzhUAfhH9qcrMZvThHeoU34MA+IywaIO95DX3HX+KSC7XFw1Wic/Olzlnr5gHGFx3rdv4GOEenQKQf8KX+f6/M5f75zF8+Cd5PFK2LTd7M6/XEbxp+W9J+XyzREP/dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=HZvEt5IP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LTdAPKi9; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 312FD11401A8;
	Mon, 23 Sep 2024 17:50:36 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 23 Sep 2024 17:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727128236;
	 x=1727214636; bh=O9Q/eImCaEWCrXoZrzE5xrq6F5YUMncTztU3Tb7lqN8=; b=
	HZvEt5IPNg2ONCbdFOIUYj1y5TP7QfFXn6dSsbLLHlKnIbcFf+utUjHwJqjuHuXO
	18HORSZinuDOb7QKRQsauCYDcsl7M/lO7pviDzkucfJzLxF1lukaHkqTbxMIQ5hO
	G3iXDwn0c3zjdyXNooZ5cPABBvZvga8wN1TajU4LLB1X+QAiejGirdGa9+XCZ84K
	3plNKso1qqrITtT25EFc/3NHewLVOYKMMqrAFaGB1iIHSd4l+le/KBlhu2MNmM3S
	InTcVAIxIyuwcGopqToG8zH4D4kzpAY79xlz2BxfLN8GDRNfuipSLUbrGG7V0vS1
	SKVfXOpJ6ouZB7cIzgA0UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727128236; x=
	1727214636; bh=O9Q/eImCaEWCrXoZrzE5xrq6F5YUMncTztU3Tb7lqN8=; b=L
	TdAPKi9+eBrZKoZTjMK31/zAtWm9vVP0VWE3G6++eab6VAuHyYw2ylMea7CfrZqo
	cr5IubP4/pbRtrfrFukOnyHP3FCLKLaPW4d2DFu/M7424hj2YfpGoaceNLxuB0GM
	5ci5L//lGHGBUA7D75pILD49fUoD0U43SalKQOLr8HgPCT7SyTEeaIo4OQaZzNDo
	mQOjvwrJ3mb2sRfnFNhLh7HluYxfeSLQLV9ArILvUXGatLQ7eXSJpt5tQzASJ8zn
	aoLbqEyQaO8rvCQuA8jkzLq+udRLapqjzEAAzPQRMPhBIAMhwhsdZ9VYc0TGx7f3
	DHVbmt3xpHxIPJA5+SexQ==
X-ME-Sender: <xms:q-LxZvRdb2aFCNDyDFT-neInijQp55NalNUJarYTmS4AXKBHiZcRpg>
    <xme:q-LxZgxVuigNDfOV764U1ZwggcBq_fKvRRn1AG5ZmQjtnVSjLkmMLUZAA5NgFisjO
    2QrUCDcbQ4Pj4hh-0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddttddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsuhhrvghnsgesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepmhhinhgthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtoheprghkphhmsehlih
    hnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehshhgrkhgvvghlrdgs
    uhhttheslhhinhhugidruggvvhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtoheplhhorhgvnhiiohdrshhtohgrkhgvshesohhr
    rggtlhgvrdgtohhmpdhrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgiipdhrtghpth
    htoheplhhinhhugidqrghpihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:q-LxZk1WL4bu1SO3Y81fmQzNm4OTQ-qbMqB2lPv9sse7ULXtM1Tvjw>
    <xmx:q-LxZvBYkENMwOsRIHW_rzL6V1-Fd4D4x3x66yAUVT_FZIXJ3r9Tfg>
    <xmx:q-LxZohC4c0Gidpewc0ExEclA-5c1Rpu8ziZqUSaeb5WkbsALpWuyw>
    <xmx:q-LxZjog9tDynDg7kPbE2qi5LRqY1op5ardphEJmmLmbskGrvE3bSQ>
    <xmx:rOLxZrOVLbLhD084W92gTRAMIgmRNELKqDaoSE-sGqzrHpNnVPI_j0uN>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 928C12220071; Mon, 23 Sep 2024 17:50:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Sep 2024 21:49:43 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Shakeel Butt" <shakeel.butt@linux.dev>
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
 "Vlastimil Babka" <vbabka@suse.cz>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Suren Baghdasaryan" <surenb@google.com>, linux-api@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "Minchan Kim" <minchan@kernel.org>
Message-Id: <337e4359-37e0-4ed7-894d-6c88b3498a42@app.fastmail.com>
In-Reply-To: <c44d373d-d72b-4e62-a613-a746a2c290e7@lucifer.local>
References: <cover.1727106751.git.lorenzo.stoakes@oracle.com>
 <077be0d59cb1047870a84c87c62e7b027af1c75d.1727106751.git.lorenzo.stoakes@oracle.com>
 <njjxbroy5nvn2gxmvsvk7m23rrsoyih24nhmbmf7lpd5yzwwk7@ijudgtbiwyq6>
 <c44d373d-d72b-4e62-a613-a746a2c290e7@lucifer.local>
Subject: Re: [PATCH 1/2] mm/madvise: introduce PR_MADV_SELF flag to process_madvise()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 23, 2024, at 19:34, Lorenzo Stoakes wrote:
> On Mon, Sep 23, 2024 at 11:56:06AM GMT, Shakeel Butt wrote:
>
> +	/* Require PTRACE_MODE_READ to avoid leaking ASLR metadata. */
> +	mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
> +	if (IS_ERR_OR_NULL(mm)) {
> +		ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
> +		goto release_task;
> +	}

Any chance we can fix mm_access() to not be able to return
a NULL pointer and an error pointer?  IS_ERR_OR_NULL() is
usually an indication of a confusing API, and this is
clearly one of them, given that only one of the
callers actually wants the NULL value instead of -ESRCH.

    Arnd

