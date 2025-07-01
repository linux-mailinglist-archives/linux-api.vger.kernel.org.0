Return-Path: <linux-api+bounces-4094-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7675AEFD51
	for <lists+linux-api@lfdr.de>; Tue,  1 Jul 2025 16:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C61BF7AF6C8
	for <lists+linux-api@lfdr.de>; Tue,  1 Jul 2025 14:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B7327FB2D;
	Tue,  1 Jul 2025 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwyJlJsD"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3197027876E;
	Tue,  1 Jul 2025 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751381678; cv=none; b=aUPnVDpiskESJqvnwlHoZ/6r6/6PnoUAQbrk96SbnjpMfoabXht7iJcURMjd9CFLbeERwlGOocVFCZVQohlTJlNk0fHpBgEzmIc1uKlJgYnS2wcbI1Hprpd9p6XsCbBU06KTGJ+gTSxelaINAvuzfkYXm3pn39XCe+cgP97Gsqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751381678; c=relaxed/simple;
	bh=aCxpkUcplD3ji4+uPWLO1qpdxvveygBxmNjoYKsar14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIIk4DmNhFMiaSJMDN+OhyYfc1MhQ4NT8cJmm3E1odqZZ69h0WnXiP0mhIiPGtY0/xudKcFCaOY6chVfC656rQ8WH38EwyieEaJVK3gDos4VzTq1yUs53Y9ndkXRChnDR+QKurL0P/3Xkl0N2NX+k694d626auiLGvQcL/LW/0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwyJlJsD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805B6C4CEEB;
	Tue,  1 Jul 2025 14:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751381677;
	bh=aCxpkUcplD3ji4+uPWLO1qpdxvveygBxmNjoYKsar14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qwyJlJsDvT5JL76u6bjrvdPgYY7L2Q2ag5a4/MYID22L0KMfwTFs0qiKG1Dyr2D29
	 AUbdyOWwm4zQe6is9WO1vxK7QP569EFIklIT2E4VsCdw0++RuGoCIBMAXfOUJbJrjJ
	 fUBdmvYxMmq34IA14pWNekXJSP4DgdxDknktnle+D1FSCp7Ot4Of0wvEsrDlAYUgCd
	 YFmoOk85ChX2IudcL8xPylkAtuB7O+dRAaApmW+W3XCYjOrn2zJzhJPbqqzPUHJwLj
	 PChjhZLoY+Q9O/y7RX1X7isXk2ZoipwsH84i6d2duf3SH7dHMJvj4yZj4R4PIdyZ5m
	 L0pda2KdUd+VQ==
Date: Tue, 1 Jul 2025 10:54:36 -0400
From: Sasha Levin <sashal@kernel.org>
To: Jake Edge <jake@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org, workflows@vger.kernel.org,
	tools@kernel.org
Subject: Re: [RFC v2 00/22] Kernel API specification framework
Message-ID: <aGP2rMDoJGd9fB4s@lappy>
References: <20250624180742.5795-1-sashal@kernel.org>
 <87qzz0aaw1.fsf@pelicano.edge2.net>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87qzz0aaw1.fsf@pelicano.edge2.net>

On Mon, Jun 30, 2025 at 07:43:42PM -0700, Jake Edge wrote:
>
>Hi Sasha,
>
>On Tue, Jun 24 2025 14:07 -0400, Sasha Levin <sashal@kernel.org> wrote:
>
>> Hey folks,
>>
>> This is a second attempt at a "Kernel API Specification" framework,
>> addressing the feedback from the initial RFC and expanding the scope
>> to include sysfs attribute specifications.
>
>In light of your talk at OSS last week [1] (for non-subscribers [2]), I
>am wondering if any of this code has been written by coding LLMs.  It
>seems like the kind of unpleasant boilerplate that they are said to be
>good at generating, but also seems like an enormous blob of "code" to
>review. What is the status of this specification in that regard?

Hey Jake!

The macro definitions were done mostly manually: it ended up being
more of a copy/paste/replace exercise to get all the different macros in
place (which, yes, ended up being a huge blob).

For the syscall/ioctl/sysfs APIs I used to demonstrate the
infrastructure, I started with defining the basic spec skeleton manually
based on our existing docs and code review, but then had LLMs extend it
based on it's review of the code.

If we do proceed with something along the lines of this spec, I can see
LLMs being useful at reviewing incoming code changes and alerting us of
required updates/changes to the spec (or, alerting us that we're
breaking the spec). Think of something like AUTOSEL but for
classification of commits that affect the userspace API.

The tools/kapi/ code is mostly mostly LLM generated.

-- 
Thanks,
Sasha

