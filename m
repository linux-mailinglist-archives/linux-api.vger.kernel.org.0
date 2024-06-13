Return-Path: <linux-api+bounces-1734-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3D49070FB
	for <lists+linux-api@lfdr.de>; Thu, 13 Jun 2024 14:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC821B229F7
	for <lists+linux-api@lfdr.de>; Thu, 13 Jun 2024 12:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9504014265E;
	Thu, 13 Jun 2024 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=owlfolio.org header.i=@owlfolio.org header.b="uOKTDpVs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fpuC6+rc"
X-Original-To: linux-api@vger.kernel.org
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E2B384;
	Thu, 13 Jun 2024 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281947; cv=none; b=aBr/znKIf67X9ZfLScEYLU1z/uZxtk6xA2865HMpOZLFNuMpalMp0sjmS8E7lv53YSk0fZVLgjYZQt1etKakVJsnKI8FuXIBCtzzNr9fAC9TzWqQERmX601vxcPMjSB31IfM8sB6/cJUAnWSEUC8G7WVMtv5yx0QFagfKEAlmZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281947; c=relaxed/simple;
	bh=g1W5nsxXD3g2wzkJjdXONv96BUw83J0qUTyM1mdcxJw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:
	 Subject:Content-Type; b=Nbv0FtYhO+VaNc5ThtYLYxPmzFopeCibrzUtMIuzwadkco1ejRvLDIXTYIvXi+hk4uvrkiTlISnQL12LEakLMwj47a0Q2NygdxT81MmB4xkYiV+ElnZSlDIG4IpxtcJB6rkazeMoxQimC07bJzQulz97NBaEOyrkc6ncyd2t+Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=owlfolio.org; spf=pass smtp.mailfrom=owlfolio.org; dkim=pass (2048-bit key) header.d=owlfolio.org header.i=@owlfolio.org header.b=uOKTDpVs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fpuC6+rc; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=owlfolio.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=owlfolio.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 3EF4D1C000E9;
	Thu, 13 Jun 2024 08:32:23 -0400 (EDT)
Received: from imap45 ([10.202.2.95])
  by compute5.internal (MEProxy); Thu, 13 Jun 2024 08:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owlfolio.org; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1718281942; x=1718368342; bh=g1W5nsxXD3
	g2wzkJjdXONv96BUw83J0qUTyM1mdcxJw=; b=uOKTDpVslHU1Kew2elddU0GmN/
	3DmWmzc0IDQiiNly6XCB0ScR2j7OXWzvs/7NkDC9X64h3I1nJsmRzqSoWdpA+8uv
	4gu0gGCMNB2BXUk/cTPdYZqPrq7FsEXO2JLDqatAwQuFlzBUUa60OkLhjYUfis73
	3X72VL5eUheUcyxX/F99W8AJnK/2GMGAq2o8rEbPD+DIGhvoDFh5+CnfXeWRkmsx
	E8/IJ5EHcIf5Pzuurg9WAKoj/esqpG3hvpyB4001lFVYYGeJVJVEL+N+mPZIlYR9
	hNAXXI1Kj6ecmXhBcAJY/MS57tbM2++bymaYVfHf5OEjVbsuaVQx0kwTLqmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718281942; x=1718368342; bh=g1W5nsxXD3g2wzkJjdXONv96BUw8
	3J0qUTyM1mdcxJw=; b=fpuC6+rcxLVKLPIMC9QH5M6nWX6jbBxVKcTCMCZ27X9J
	Q9REx4fpmb2kqQW6xlnJ/dn/g/kGp6IgqeX0AclBoO6WsPMfaXChIZvFd7MGTS/o
	2bCmKZoiLKhYPZ8uSS5H2cR0eqX1i+1yoRZXZj+j53nZFaWSzBGjoXvetoeVQtyv
	W0rpGcFDhwxFOatA1R92IxyGq43wAWLlTIXoIEK22XY+3AQozk/j9r7lkkqvW12d
	4JlUnFOFPbhTz3FEagRxS2qos4iZQANbQQ60RAH48KcAVE6L9UBoRk5NO8Is2Y1n
	IBtzjFLyMlNq80++PfWaYTFM60w9mUixiBL+1Ua2kg==
X-ME-Sender: <xms:1uZqZtSuKwX0sls1a2OQ5akch0P7HdN3Y9a7uQX0MD8iO5twgZWhFg>
    <xme:1uZqZmwEEr463537jDHFTYDtfTEWuwfMeFQA6UrAfogPA8W1Y6zbNXQvm35ufP1t1
    eUnKcaHmMny9cdvc-8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedujedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdgkrggt
    khcuhggvihhnsggvrhhgfdcuoeiirggtkhesohiflhhfohhlihhordhorhhgqeenucggtf
    frrghtthgvrhhnpefhuefhveeuffetfffgjeetgfekkeehfedtfeelgfehffffveehkeel
    fefgheffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpeiirggtkhesohiflhhfohhlihhordhorhhg
X-ME-Proxy: <xmx:1uZqZi1CldBIXzFvXhtwMHHqzvjQOIR22EAhAjuJGOlhM08FBk_Plw>
    <xmx:1uZqZlAHYTW0wn26BJSmJfF2sffsbQGX-FD_I2y9lKiV17wymebKlw>
    <xmx:1uZqZmjB5UAqKuxf1YjQ3PFotd1_-7V5pILuMaUsl64x4rG3AQKcaA>
    <xmx:1uZqZpplXQrF0XxB95i2IqSEE3cj4K0-p-PkGWGXDoMNTaezmSWrGg>
    <xmx:1uZqZhVx8gqbInQ6Zv5F0HzcBf4U1K24Kt1jFe8WKW1y_KpKCAa5fvsg>
Feedback-ID: i876146a2:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3CF58272007C; Thu, 13 Jun 2024 08:32:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-515-g87b2bad5a-fm-20240604.001-g87b2bad5
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f6ee2bd3-c1b7-4769-a313-b62f42c450ca@app.fastmail.com>
In-Reply-To: <87af5e8f-0dcb-44a0-94de-757cad7d5ded@cs.ucla.edu>
References: <a7kfppfptkzvqys6cblwjudlpoghsycjglw57hxe2ywvruzkbd@e6nqpnxgwfnq>
 <87af5e8f-0dcb-44a0-94de-757cad7d5ded@cs.ucla.edu>
Date: Thu, 13 Jun 2024 08:32:01 -0400
From: "Zack Weinberg" <zack@owlfolio.org>
To: "Paul Eggert" <eggert@cs.ucla.edu>, "Alejandro Colomar" <alx@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Palmer Dabbelt" <palmer@rivosinc.com>, linux-api@vger.kernel.org,
 "GNU libc development" <libc-alpha@sourceware.org>,
 'linux-man' <linux-man@vger.kernel.org>
Subject: Re: termios constants should be unsigned
Content-Type: text/plain

On Wed, Jun 12, 2024, at 10:55 AM, Paul Eggert wrote:
> A lot of this stuff is pedanticism that dates back to the bad old days
> when the C standard allowed ones' complement and signed magnitude
> representations of signed integers. Although it can be amusing to
> worry about that possibility (I know I've done it) it's never been a
> practical worry, and even the motivation of pedanticism is going away
> now that C23 requires two's complement.

Unless C23 eliminated *all* the cases where an operation on unsigned
integers is well-defined but the same operation on signed integers is
undefined, and last I checked it had not, there is still a need for
caution around conversions that change signedness.

zw

