Return-Path: <linux-api+bounces-6051-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L3BLiSezGlFUgYAu9opvQ
	(envelope-from <linux-api+bounces-6051-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 01 Apr 2026 06:25:08 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6B1374A53
	for <lists+linux-api@lfdr.de>; Wed, 01 Apr 2026 06:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A88D630CDA66
	for <lists+linux-api@lfdr.de>; Wed,  1 Apr 2026 04:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551DB37F00B;
	Wed,  1 Apr 2026 04:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoAsePdW"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207F735BDAD
	for <linux-api@vger.kernel.org>; Wed,  1 Apr 2026 04:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775017199; cv=none; b=S7fbWMvw0OwYliCNMoT1xiWjrbV/uMbFawSqkcIr0QDt9AzXeAX8uIpXCkJ4sUtd4ZEbDVeFLm64kUjba64WsHerQ4TqXuebbgYEPF9RS51umsk679ahLCZIMvmhp6kInB4farqMmGa8f8nlJBDwVLdZTEVqzkyEOnGwY7RgcR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775017199; c=relaxed/simple;
	bh=GW93UXZZL/AJcKizbF9MiVumq3K474SVj7RsNaKwVOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvixUcRVMm42DQHjM0eVor+lg64D1aPd6EEuAsqJHKO2dpuJ99JopJzP9TXkHtE69suIrZSR6gUFAIitgmV3yGmadnAuf33ZpkfSoCU5PZnQ+HxlSgBYkci4lRBEcSjFMwcEO2WdUUrCK2Zp3Go4+Rjwp/WQwJtt67RcbscvcyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoAsePdW; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cfbd17589so2978725f8f.0
        for <linux-api@vger.kernel.org>; Tue, 31 Mar 2026 21:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775017195; x=1775621995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FpxTHYW9PCEMGlcpR0vGWm0MEHjo8lB3T6MyF9di0eg=;
        b=SoAsePdWP+Ziu75muCsKjEsNT5foNHSfACGEKlH+KoatdtogWSGBjns4ClD/iv4mJt
         Ri3qw7tPE90PLba3ryuu4fY+h1eQFTRZUhq6wVZopWnamtXCXY6ehGhl5fxtIu2R+0JD
         Ed1GhIHmbKmeBVHjtNqhv9+Jy7nluoh9gRQe0vHgmf/Xs+c91QYDTLI2bG58VEyyp67k
         vHG0GmkP/UA0TJFx0xmDqPLIuKKwg5DE+5gR0QUop0Ywgs8XzWcEXy01CrNF9hW3TH6I
         SmNNdxw1ImY+Y598Oc1pxiLHnTMZsEt1bKCenZRGU2GjSCFIJ4YhSJM2huqsHZbGNfIY
         NOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775017195; x=1775621995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpxTHYW9PCEMGlcpR0vGWm0MEHjo8lB3T6MyF9di0eg=;
        b=NU5TAyDd6X3lXrlFMxzwV8QLJnILwfqvEmnNHnETiBkHrxmaaSqq9zF0qsa35BeSwk
         qpJhHgCK0biEVV9yN+LJ6e2HdBnAY2xeulvnETBL/7iGAyWTNnWaQA+oPuX6oXlVGG73
         aEMt5WM6rboZsRTT70QUqsft56cF/JCkYMfvzx0C0Vb6EVPItMjXC+gC9jUmhzuNdP7Q
         pSTFEtmOf7hPE45b1oIiS/K96dAACdfcOoBojJhHDarPyAeqjtI7uoq4osNELYjhwCo7
         pr0QpUnrFbDH8k/Psn7qfwF1VBuhxKMPWcnG4F9hSxe6uT3a12E64a+7b6FJzTPR2ULL
         xHMw==
X-Forwarded-Encrypted: i=1; AJvYcCX7iZuK82I+D4OTLvsSbZRNasCZtgUrgqO4CflAxpSTfK9lDWTllz2CP4lJR1aPlh08UOPYxWIhkCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCUKdIL4210kF+xVsrkoLW++qBG8+DVPz+VytM/++Qnqss7ipu
	sKy9XoWuIlbzuK6zU5UZJi07IikxOnop7vjKdC0+l3K6V6cnyBJpHgSj
X-Gm-Gg: ATEYQzxtqynMUCaBH3uDrH74tttZLrEu/CHX3THwR0h+IqbaYZmdP/Ijx+nhAxduZL+
	1v9p894YOfzgAZEDcZEdjFN7OUeJyvIWjsOTTjZO0YEB/tefl7haDpcwO8ZoTAXneCKLnShO0Nl
	4JEsx2bqcVHTZjTmo/5DU/79bxkmJrEumxJszSbyS/t03cj4sYHIzHEbRF8xmOoPFM5qf7grFoo
	O3qVVf9MuobnDvjXYLH86T7ZXyCAYTLNHrPafRQ0RTi+cicOTUteJhYq7IvTI4WCAcNF228Evqv
	/LioPrn34MrqvcauhzYzOno2yzYw2pAtEFVON+YcS+cUDVESwvPv9Q+aMTAnnt6KywHC/AmELNO
	fbbhlEsoRYsWzhGCk32WN5DGYu4bT/Wm+U2vLpuoP2ap0rX2CTbOkkcb9xOf3x+/Hs5s+/lEdai
	8Wrc+n/ldxE1mJtp+2na8uIZ3qGN64p657gVqVT/3/BBNaeg6gytkuCij/32tnjmL3anbuCvI=
X-Received: by 2002:a05:600c:c178:b0:486:f8e9:add5 with SMTP id 5b1f17b1804b1-48883591777mr30069195e9.19.1775017195266;
        Tue, 31 Mar 2026 21:19:55 -0700 (PDT)
Received: from f (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e7e9728sm87601455e9.1.2026.03.31.21.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 21:19:54 -0700 (PDT)
Date: Wed, 1 Apr 2026 06:19:40 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Alexander Aring <alex.aring@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Andrey Albershteyn <aalbersh@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Aleksa Sarai <cyphar@cyphar.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, cmirabil@redhat.com, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [RFC PATCH 1/2] vfs: syscalls: add mkdirat_fd()
Message-ID: <pbobkjhtuli53o3z34ajyxztaosmztwlygxfxhhjq5ajt47inc@ngtoge3ucdm5>
References: <20260331172011.3512876-1-jkoolstra@xs4all.nl>
 <20260331172011.3512876-2-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260331172011.3512876-2-jkoolstra@xs4all.nl>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6051-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[xs4all.nl];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zeniv.linux.org.uk,oracle.com,arndb.de,linuxfoundation.org,zytor.com,suse.cz,gmail.com,infradead.org,efficios.com,linutronix.de,cyphar.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F6B1374A53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 07:19:58PM +0200, Jori Koolstra wrote:
> @@ -5286,7 +5290,25 @@ int filename_mkdirat(int dfd, struct filename *name, umode_t mode)
>  		lookup_flags |= LOOKUP_REVAL;
>  		goto retry;
>  	}
> +
> +	if (!error && (flags & MKDIRAT_FD_NEED_FD)) {
> +		struct path new_path = { .mnt = path.mnt, .dentry = dentry };
> +		error = FD_ADD(0, dentry_open(&new_path, O_DIRECTORY, current_cred()));
> +	}
> +	end_creating_path(&path, dentry);
>  	return error;


You can't do it like this. Should it turn out no fd can be allocated,
the entire thing is going to error out while keeping the newly created
directory behind. You need to allocate the fd first, then do the hard
work, and only then fd_install and or free the fd. The FD_ADD machinery
can probably still be used provided proper wrapping of the real new
mkdir.

It should be perfectly feasible to de facto wrap existing mkdir
functionality by this syscall.

On top of that similarly to what other people mentioned the new syscall
will definitely want to support O_CLOEXEC and probably other flags down
the line.

Trying to handle this in open() is a no-go. openat2 is rather
problematic.

I tend to agree mkdirat_fd is not a good name for the syscall either,
but I don't have a suggestion I'm happy with. I think least bad name
would follow the existing stuff and be mkdirat2 or similar.

The routine would have to start with validating the passed O_ flags, for
now only allowing O_CLOEXEC and EINVAL-ing otherwise.

