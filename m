Return-Path: <linux-api+bounces-2086-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B15C0944B28
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2024 14:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39B21C22521
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2024 12:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58410194C73;
	Thu,  1 Aug 2024 12:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="LZulTTnt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UT2UZhbz"
X-Original-To: linux-api@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AD816D9A8;
	Thu,  1 Aug 2024 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722514881; cv=none; b=RxPYv4T62bimN70JdzjzQXRvKVJnSB3Gl5vK4O11N1GpLTFMwQnaivQisNN5MX0JTM576ogaLAzmRWgFkzpyoTVCNv45GCbLqEcOLxklikIwztOvRDGt74d5HuouMKnaEkdKDTIdukZebRjLN2Xzocn6Lnbb5RbjVheCrv6MZbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722514881; c=relaxed/simple;
	bh=v5AqnbToYhn+a54KtathEFCw891coto36Z6SDjTMZvU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=S1awiPdKUQQ5kLqmmAtlqEUvbIB95d8yjhahwZEt03QLFiVlu4xvMn6XI5BI1GjzIESNmvVUg+dybFjuTM3tgqjh389sIvJ0W9bc6WvielGSIJgteIH5AQT43NgqzSG09krUXhsEW6vZrk7uF6lYqknsTvla8X/cQ2vnOMoc6Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=LZulTTnt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UT2UZhbz; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D4B64114ABE8;
	Thu,  1 Aug 2024 08:21:17 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Thu, 01 Aug 2024 08:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1722514877;
	 x=1722601277; bh=vV5sdXdNa6xlWYqVfiBfR5jLSm7orJ7WB4HwS9PkwUI=; b=
	LZulTTntvqxgZy5gZdPvC12YoS0nkXO6ut3gaH6T82/hDmBlnapzVpoLVTOyfdkG
	nK/qs0CngjcmukeN+RERJiZsE+aaUkdiO5fMLckMyiIGhO5wiB39AoGi9du2F2kJ
	WunqfIlP3+roqGsMDa7F31JFOVc4B6XOxWvxjU5+mgnjZwXOg4bEFg+7TXOi3qK6
	o1ab/S92hbxHryCxFWCvkhfeENJTZqHP8q6UpTi/szlwyyvr4lfifdlEDqGJVRFr
	7/nJ2qzo11ebmRdAF2Ej6wGByXTvmNsqL+O97lt7SaAMAxero74W52VQ5sbIbyQP
	jhi21kUMmJBpa4lo9BNMlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722514877; x=
	1722601277; bh=vV5sdXdNa6xlWYqVfiBfR5jLSm7orJ7WB4HwS9PkwUI=; b=U
	T2UZhbzClosovJY9C/1iusT39oRq/ULwnER14Tozi3+S1sCTQC3vbwy3EfG6EaUd
	RPtFaAvp4pI+6VID852NkjC6ZFWyfhdoJTUIOp6zyMmixsNG5DHA6rEkFBv7IiGr
	Zwu4BuWmn9tpD6HuzLmM1bDv0Jm5AegqMRN/3ryVrDGlCrX8MJLJQPPu3GvXfEOB
	u0RYo9fahdpaMKOFgZN36zWH6qg921ISdxG1EkrjFLZNoCq3GzTZsA4VsE+mPUiM
	DYFDEcY63+7nRMOCIgjKlnPKp+1LjV34le0G6/8I0+K94sJGaszKWISb61bTi+ZJ
	DmcwUyvvmT5K4Avg6sz/g==
X-ME-Sender: <xms:vX2rZrxMNds7rJoaDzGPkTywNnZLv0WBLwA2baA2XTzTPnf1iO3hQw>
    <xme:vX2rZjSw6EVCJ_B4hNUaFQOllUaEiDZUuqCrNgGo2VGxDwQSgoBxf_paCaTJjm66r
    AQgE3976NjqYjue8JA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdv
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:vX2rZlUWslECp0g2ozp_uLXMzrZG6L0gNwC7s4_A-ZZxMiZzRDikyQ>
    <xmx:vX2rZlhMI1qcQJuJHxeGKABPwaFp4exD4-cbLkj-sFUjn6eoTWrj-Q>
    <xmx:vX2rZtBVAgV8gSBNem1bcLWXKyShKPi2gpJbToGrHoqfHINjkNA9Bg>
    <xmx:vX2rZuIFvje9Dfn1aAWbexWiDSiw3TuLbJZu9kpD8dxq4j6zWWmGiw>
    <xmx:vX2rZv1YvwP_b1AMFG2i72yw_lvMYajM8S0Bt8rq6FIHVQ_De0rjuNXg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 95B78B6008D; Thu,  1 Aug 2024 08:21:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 01 Aug 2024 14:20:45 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andreas Schwab" <schwab@suse.de>, "Florian Weimer" <fweimer@redhat.com>
Cc: linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Catalin Marinas" <catalin.marinas@arm.com>
Message-Id: <838053e0-b186-4e9f-9668-9a3384a71f23@app.fastmail.com>
In-Reply-To: <mvmh6c4fors.fsf@suse.de>
References: <87sevoqy7v.fsf@oldenburg.str.redhat.com>
 <mvmh6c4fors.fsf@suse.de>
Subject: Re: syscall.tbl refactoring seems to have dropped definition of
 __NR_newfstatat on arm64 and riscv (64-bit) at least
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Aug 1, 2024, at 13:47, Andreas Schwab wrote:
> On Aug 01 2024, Florian Weimer wrote:
>
>> It's been repported that __NR_newfstatat has gone missing from the UAPI
>> headers.
>
> It has actually been wrongly renamed to __NR_fstatat.

Ah, I see what happened now, this was part of a semi-automated
conversion from the old format and I incorrectly split up the
entries between 32-bit and 64-bit.

There is another bug in the same entry, since in the meantime,
we have also decided to make newfstat/newfstatat unconditional
again for all 64-bit architectures, and this hasn't made it into
the new syscall.tbl format. This one is only important for
loongarch64.

I'll fix up both ASAP, thanks a lot for the report!

      Arnd

