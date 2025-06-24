Return-Path: <linux-api+bounces-3954-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 164BAAE67D1
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 16:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85542189E4B2
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 14:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4322D2386;
	Tue, 24 Jun 2025 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lNrOrHnV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QAr11eEI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lNrOrHnV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QAr11eEI"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF232C374E
	for <linux-api@vger.kernel.org>; Tue, 24 Jun 2025 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750773955; cv=none; b=rWw3cbB9Wp+ph337KsCkD0ugsNusgBs8dtTHAsZPi/u6jwhHnvMIY2eAkYCs9OKdQ+0zTglyCFj67hjWt252E0KOKZpqo/8eY39QX11+twxgl7KqfgV55iIu6THCZiilWiOsMdUnFN8n8jUazM9oLLkvS2A5qeDsOFaTiV/451g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750773955; c=relaxed/simple;
	bh=b82Sl48i4HaD9mfydXB7+D4f/xFkM7JWCjfJ/FznMvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xo19+LOV0/NQbhytRm6BUgqFNSxeGIMzPD4I19vRbvZ4IQymXrnGlZvZ6kdHX0jgMeCAd5ZJ5HmgW9tTjpklBC/opf2FDfn+avxyoaAKaxnBHXnD404iyMJOcotCXKVQci0GI93uBhaVYGHvhKPf8C1dxap7uw3Ts+q/+cm5LQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lNrOrHnV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QAr11eEI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lNrOrHnV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QAr11eEI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 483FC1F444;
	Tue, 24 Jun 2025 14:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750773952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFQH2JgdAPVFzEwVQ4z26a3AfD97xOT2djRZ/ji3+L4=;
	b=lNrOrHnVnIa7wAHKfjbC7taRu2dDmbTchDvDF6lTwdNMe3+MJNigzqZoiLN53OoIrXIQZw
	a88u2h2HVrWAYJO6tcWutQA+UKZxIBC6cEVPrp5PJUWb6ipcpgHWwNRcMgNLnmCp6Q1/Cw
	Y351ixvev2IUmP3CI14cKBXeeopJ8l4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750773952;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFQH2JgdAPVFzEwVQ4z26a3AfD97xOT2djRZ/ji3+L4=;
	b=QAr11eEIQwDDlZeah0/BKey83ySm9x395yNpy7eoXQo/VfVD8wxFNsM2fmuGrU1/zYm1vC
	d8oRQNJ7152rz1Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750773952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFQH2JgdAPVFzEwVQ4z26a3AfD97xOT2djRZ/ji3+L4=;
	b=lNrOrHnVnIa7wAHKfjbC7taRu2dDmbTchDvDF6lTwdNMe3+MJNigzqZoiLN53OoIrXIQZw
	a88u2h2HVrWAYJO6tcWutQA+UKZxIBC6cEVPrp5PJUWb6ipcpgHWwNRcMgNLnmCp6Q1/Cw
	Y351ixvev2IUmP3CI14cKBXeeopJ8l4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750773952;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFQH2JgdAPVFzEwVQ4z26a3AfD97xOT2djRZ/ji3+L4=;
	b=QAr11eEIQwDDlZeah0/BKey83ySm9x395yNpy7eoXQo/VfVD8wxFNsM2fmuGrU1/zYm1vC
	d8oRQNJ7152rz1Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3637A13751;
	Tue, 24 Jun 2025 14:05:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vFrEC8CwWmgedgAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Tue, 24 Jun 2025 14:05:52 +0000
Date: Tue, 24 Jun 2025 16:06:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: sashal@kernel.org, kees@kernel.org, elver@google.com,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
	tools@kernel.org, workflows@vger.kernel.org
Subject: Re: [RFC 00/19] Kernel API Specification Framework
Message-ID: <aFqw5-PO4MjsEdYU@yuki.lan>
References: <aFNYQkbEctT6N0Hb@lappy>
 <20250623132803.26760-1-dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623132803.26760-1-dvyukov@google.com>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

Hi!
> 6. What's the goal of validation of the input arguments?
> Kernel code must do this validation anyway, right.
> Any non-trivial validation is hard, e.g. even for open the validation function
> for file name would need to have access to flags and check file precense for
> some flags combinations. That may add significant amount of non-trivial code
> that duplicates main syscall logic, and that logic may also have bugs and
> memory leaks.

I was looking at that part and thinking that we could generate (at least
some) automated conformance tests based on this information. We could
make sure that invalid parameters are properly rejected. For open(),
some combinations would be difficuilt to model though, e.g. for
O_DIRECTORY the pathname is supposed to be a path to a directory and
also the file descriptor returned has different properties. Also O_CREAT
requires third parameter and changes which kinds of filepaths are
invalid. Demultiplexing syscalls like this is going to be difficult to
get right.

As for testing purposes, most of the time it would be enough just to say
something as "this parameter is an existing file". If we have this
information in a machine parseable format we can generate automatic
tests for various error conditions e.g. ELOOP, EACESS, ENAMETOOLONG,
ENOENT, ...

For paths we could have something as:

file:existing
file:notexisting
file:replaced|nonexisting
file:nonexisting|existing
dir:existing
dir:nonexisting

Then for open() syscall we can do:

flags=O_DIRECTORY path=dir:existing
flags=O_CREAT path=file:nonexisting|existing
flags=O_CREAT|O_EXCL path=file:nonexisting
...

You may wonder if such kind of tests are useful at all, since quite a
few of these errors are checked for and generated from a common
functions. There are at least two cases I can think of. First of all it
makes sure that errors are stable when particular function/subsystem is
rewritten. And it can also make sure that errors are consistent across
different implementation of the same functionality e.g. filesystems. I
remember that some of the less used FUSE filesystems returned puzzling
errors in certain corner cases.

Maybe it would be more useful to steer this towards a system that
annotates better the types for the syscall parameters and return values.
Something that would be an extension to a C types with a description on
how particular string or integer is interpreted.

> Side-effects specification potentially can be used to detect logical kernel bugs,
> e.g. if a syscall does not claim to change fs state, but it does, it's a bug.
> Though, a more useful check should be failure/concurrency atomicity.
> Namely, if a syscall claims to not alter state on failure, it shouldn't do so.
> Concurrency atomicity means linearizability of concurrent syscalls
> (side-effects match one of 2 possible orders of syscalls).
> But for these we would need to add additional flags to the descriptions
> that say that a syscall supports failure/concurrency atomicity.
> 
> 8. It would be useful to have a mapping of file_operations to actual files in fs.
> Otherwise the exposed info is not very actionable, since there is no way to understand
> what actual file/fd the ioctl's can be applied to.

+1 There are many different kinds of file descriptors and they differ
wildy in what operations they support.

Maybe we would need a subclass for a file descriptor, something as:

fd:file
fd:timerfd
fd:pidfs
...

-- 
Cyril Hrubis
chrubis@suse.cz

