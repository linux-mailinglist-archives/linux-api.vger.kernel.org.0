Return-Path: <linux-api+bounces-6070-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UA4fLQ9G1mkFCwgAu9opvQ
	(envelope-from <linux-api+bounces-6070-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 08 Apr 2026 14:11:59 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 636093BBD01
	for <lists+linux-api@lfdr.de>; Wed, 08 Apr 2026 14:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3CCF306769D
	for <lists+linux-api@lfdr.de>; Wed,  8 Apr 2026 12:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CFA3B27DA;
	Wed,  8 Apr 2026 12:11:35 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134753ACF04
	for <linux-api@vger.kernel.org>; Wed,  8 Apr 2026 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650295; cv=none; b=VfZvHTzq2tZa7YT0DTCvriB9q78wmrqATShsv7E6EKXInFWpDBdfm9lhTJSvMqV7c554lA74oJ7WpupLr4n9Hhzp8qy0QZCmD8x3a/rlIUwoXq6LqN2liOpHOk+gi3gTQyMNutD56GKWIsiRxqh02gtD08n7Y8SJLmgfmVbiNiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650295; c=relaxed/simple;
	bh=8scfsOfxjJCA7PsheVSzcMVVAN4HZJ5wygd7fo905BM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVO8X5rTwVC9viz5QKRTxUZ7NYCUw8CcAaDnsf2aBa3qa4Swmhgk1d0foOD7POhgHpPD8zsqUS+IYLur0nStuuErwix/V/wCg1+3l4QxI26Mc7yBKVtPacPRlDPMyEHnV0sFXNlICKagKZROaO+MOiBciXupqxgAZqV1L4M/wFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-951a4e8d1b5so1838729241.1
        for <linux-api@vger.kernel.org>; Wed, 08 Apr 2026 05:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775650293; x=1776255093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGRbYznGbDw7bAVfW0akDmACi6u2DoC61pG2AP+p98k=;
        b=o4u6f7DFDelz4RqU38uoG1aDFkB2N6YRCjRWfw4WNRFR67g0iSLwkyaUQ1jR6xIuHd
         /4tPXs/aHxQk/45FRoWqhZUdBcZb8CjUY6mWN2eW7VOdr9fiNErpnY/HfxcLyCFLLEDj
         ItfsMfPrTISRIakA6FPc3Cx9ssWbMGSPKGZMTTmRJXX6hCZhwm64GG4lZP7NbmcKDeVe
         IWU9hA3TL894cDd6jX/y6SXwId/sx5+k5hrdlENeK5833ellbDpGA87T5jWNNuZHN3sF
         rfHAFlgp7zGOBNjWmLvlR6s3Id9aGWX5Iym/2xbxsvX7HNgLaNP572bik2m//rqrNMg+
         N9vA==
X-Forwarded-Encrypted: i=1; AJvYcCWyQDliNPrQTD6z5pBKqZ0VQk0ZUHYnuYVXPpfI6fJ7aIB/1YW/tt2fnvvYVVawknIF2zzhQe0DVYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFk14zXvAIVLcph7CB6jifPs4+6TaRLwFTYzwVnEvPYzuquYcp
	0mH+ney5X1tSGFn252QdiAi/pcdB0Vm1MxHJJUtp+i9819hg4HDF5cUw881DaYeg
X-Gm-Gg: AeBDievv8Ay5LgvyS1DsF8CKxte4upidsFNClftfQpX5IzuZilP96Jx+h0sSjOtnmQZ
	/KNMWU1gBb6C2LO1GMqLr8L08iJpE7I8hSUwukHavk16XWhGmXJmhaw8v7F3qU9gm8T8wMh+KOt
	KMczUDN7eIa3lVqC5zSxbHlSg3g1a9/Xei9Gr0XW2vci4Pg2Pxl9ngWR0nYe8OWgkFzxtKYUB5k
	6AoaUy6fVQIxnYsrCZsTkkLXD+f6Ci/Y20INh7X3W8qVf4HzrFt/Q4UFJ+RB2RfQlJZ9KcQ9vpi
	VDSBTThCOfKzTCoHjvo+jICuhYfGzORsUlOpteiETobpzB+ehCGxWVbXbqPEb717GgYajmlcyAu
	saKvDoH4wyyJuBCGBQPbUYfqCDWnRM7JI8Hw+D0Z3EK1hvO/YvRcOEZ4TACbuvZFq7PUNsbTVM/
	fSqiz5jO/xR6epUs8lJt+oNISUrsOcsDXJakxDsyXGqvMLWYjlVbGGENL4pjT02kxv
X-Received: by 2002:a05:6102:e10:b0:5f5:4055:4556 with SMTP id ada2fe7eead31-605a4c96273mr7219566137.4.1775650292811;
        Wed, 08 Apr 2026 05:11:32 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ab9acde805sm60790706d6.2.2026.04.08.05.11.32
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 05:11:32 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50b2b289925so53860161cf.2
        for <linux-api@vger.kernel.org>; Wed, 08 Apr 2026 05:11:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbFyGeNplCMbUCmFqgGq5j0DHIqWu5kJ6gHWOYXrtVgPF/JEFZVyxRCynkGKz40kMGNRsoHOTvJkE=@vger.kernel.org
X-Received: by 2002:a05:6122:3784:b0:56d:92dd:a0ad with SMTP id
 71dfb90a1353d-56daba970e8mr8020585e0c.15.1775649953503; Wed, 08 Apr 2026
 05:05:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313150928.2637368-1-sashal@kernel.org> <20260314111822.63a2ba4a@kernel.org>
 <abZTg9ZwnE5J4qXa@laps>
In-Reply-To: <abZTg9ZwnE5J4qXa@laps>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Apr 2026 14:05:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU5Ga9WCzD8ji8kgOMmosS+uzf_8mp_OkhFdcAg2=3KAg@mail.gmail.com>
X-Gm-Features: AQROBzA3VNDAkN7JQ2RBFKXcNeNTnnQqU_cNeGRDhYiY7nC0FR4lVKTSqS90qsM
Message-ID: <CAMuHMdU5Ga9WCzD8ji8kgOMmosS+uzf_8mp_OkhFdcAg2=3KAg@mail.gmail.com>
Subject: Re: [PATCH 0/9] Kernel API Specification Framework
To: Sasha Levin <sashal@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, workflows@vger.kernel.org, tools@kernel.org, 
	x86@kernel.org, Thomas Gleixner <tglx@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Dmitry Vyukov <dvyukov@google.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Cyril Hrubis <chrubis@suse.cz>, Kees Cook <kees@kernel.org>, Jake Edge <jake@lwn.net>, 
	David Laight <david.laight.linux@gmail.com>, Askar Safin <safinaskar@zohomail.com>, 
	Gabriele Paoloni <gpaoloni@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-6070-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linuxfoundation.org,lwn.net,google.com,infradead.org,suse.cz,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-api@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.077];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux-m68k.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 636093BBD01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Sasha,

On Sun, 15 Mar 2026 at 07:36, Sasha Levin <sashal@kernel.org> wrote:
> On Sat, Mar 14, 2026 at 11:18:22AM -0700, Jakub Kicinski wrote:
> >On Fri, 13 Mar 2026 11:09:10 -0400 Sasha Levin wrote:
> >> This enables static analysis tools to verify userspace API usage at compile
> >> time, test generation based on formal specifications, consistent error handling
> >> validation, automated documentation generation, and formal verification of
> >> kernel interfaces.
> >
> >Could you give some examples? We have machine readable descriptions for
> >Netlink interfaces, we approached syzbot folks and they did not really
> >seem to care for those.
>
> Once the API is in a machine-readable format, we can write formatters to
> output whatever downstream tools need. The kapi tool in the series
> already ships with plain text, JSON, and RST formatters, and adding new
> output formats is straightforward. We don't need to convince the
> syzkaller folks to consume our specs, we can just output them in a
> format that syzkaller already understands.
>
> For example, I have a syzlang formatter that produces the following
> from the sys_read spec in this series:
>
>    # --- read ---
>    # Read data from a file descriptor
>    #
>    # @context process, sleepable
>    #
>    # @capability CAP_DAC_OVERRIDE: Bypass discretionary access control on read permission
>    # @capability CAP_DAC_READ_SEARCH: Bypass read permission checks on regular files
>    #
>    # @error EPERM (-1): Returned by fanotify permission events...
>    # @error EINTR (-4): The call was interrupted by a signal before any data was read.
>    # @error EIO (-5): A low-level I/O error occurred.
>    # @error EBADF (-9): fd is not a valid file descriptor, or fd was not opened for reading.
>    # @error EAGAIN (-11): O_NONBLOCK set and read would block.
>    # @error EACCES (-13): LSM denied the read operation via security_file_permission().
>    # @error EFAULT (-14): buf points outside the accessible address space.
>    # @error EISDIR (-21): fd refers to a directory.
>    # @error EINVAL (-22): fd not suitable for reading, O_DIRECT misaligned, count negative...
>    # @error ENODATA (-61): Data not available in cache...
>    # @error EOVERFLOW (-75): File position plus count would exceed LLONG_MAX.
>    # @error EOPNOTSUPP (-95): Read not supported for this file type...
>    # @error ENOBUFS (-105): Buffer too small for complete notification...

The actual E-values are positive, so I guess you want e.g. -EPERM?

Note that the actual errno values are architecture-specific.
E.g. EOPNOTSUPP can be 45, 95, 122, or 223.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

