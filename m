Return-Path: <linux-api+bounces-1882-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A9C92A7CD
	for <lists+linux-api@lfdr.de>; Mon,  8 Jul 2024 19:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5648C1C21073
	for <lists+linux-api@lfdr.de>; Mon,  8 Jul 2024 17:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEF41474AB;
	Mon,  8 Jul 2024 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="iGsmbWMw"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A79F14386F;
	Mon,  8 Jul 2024 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720458357; cv=none; b=Ff4kTZRrbvyoz85rtRlKqQLWNAQJCbh51RL8tDMEeKr3jQfiKkazggR9cr8PvgJPyyaEUkiFCClLMDB0NHpzpbOa5AIYt8v6rjTVpZaeA13iotqpXXHEp35leIj5fa1BuFzzD136iYwMbQ7gh0kcm/ndhL2/+7uT9087h+TZWHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720458357; c=relaxed/simple;
	bh=uxsJY74mGnl6Pfbb3/HWHQAP4SJETbEUSAhS9KG71Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cc1R7MkcucUusQc8RLCK7aZh+EjYQJKQgGdmpONWApz+29sMJnsRtln2OK3/ZySdJc7q38cnGeCdnm/ddMAzmxVPUk/p9JwpWd6eKTrz6g311rsEyfL5/ZJoSLm8C3pvcrVaUQMAMXqKlA2/HlF8LGn0WbhufLafE62u6hRqV8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=iGsmbWMw; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WHr9Q2JFsz77b;
	Mon,  8 Jul 2024 19:05:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720458346;
	bh=rqrFtsUKnrmCy2BFEII07R6XIPCDv3T85BZjHwdXhkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iGsmbWMwtJflXK6ehzd9F4+q9ko4rI+RsU0vRG2KJenxOv9O+37g3x9xV5rgAxw8Z
	 x1SZVivMlS1QjsFvkpzoPQZqGVHx90Rr3itkH76Jq4XlBOLzK1xxTqHrU/DZq8+AiM
	 9gy+wZVKNeUrfCRAdOIT+S6aPHFpqIfzk5yYleOI=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WHr9L0CjHz70k;
	Mon,  8 Jul 2024 19:05:41 +0200 (CEST)
Date: Mon, 8 Jul 2024 19:05:39 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jeff Xu <jeffxu@google.com>
Cc: Florian Weimer <fweimer@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Paul Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>, 
	Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, James Morris <jamorris@linux.microsoft.com>, 
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Scott Shell <scottsh@microsoft.com>, 
	Shuah Khan <shuah@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, Vincent Strubel <vincent.strubel@ssi.gouv.fr>, 
	Xiaoming Ni <nixiaoming@huawei.com>, Yin Fengwei <fengwei.yin@intel.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
Message-ID: <20240708.ujeeDahkee4e@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-2-mic@digikod.net>
 <87bk3bvhr1.fsf@oldenburg.str.redhat.com>
 <CALmYWFu_JFyuwYhDtEDWxEob8JHFSoyx_SCcsRVKqSYyyw30Rg@mail.gmail.com>
 <87ed83etpk.fsf@oldenburg.str.redhat.com>
 <CALmYWFvkUnevm=npBeaZVkK_PXm=A8MjgxFXkASnERxoMyhYBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALmYWFvkUnevm=npBeaZVkK_PXm=A8MjgxFXkASnERxoMyhYBg@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Jul 08, 2024 at 09:40:45AM -0700, Jeff Xu wrote:
> On Mon, Jul 8, 2024 at 9:26 AM Florian Weimer <fweimer@redhat.com> wrote:
> >
> > * Jeff Xu:
> >
> > > Will dynamic linkers use the execveat(AT_CHECK) to check shared
> > > libraries too ?  or just the main executable itself.
> >
> > I expect that dynamic linkers will have to do this for everything they
> > map.

Correct, that would enable to safely handle LD_PRELOAD for instance.

> Then all the objects (.so, .sh, etc.) will go through  the check from
> execveat's main  to security_bprm_creds_for_exec(), some of them might
> be specific for the main executable ?
> e.g. ChromeOS uses security_bprm_creds_for_exec to block executable
> memfd [1], applying this means automatically extending the block to
> the .so object.

That's a good example of how this AT_CHECK check makes sense.

Landlock will probably get a similar (optional) restriction too:
https://github.com/landlock-lsm/linux/issues/37

> 
> I'm not sure if other LSMs need to be updated ?  e.g.  will  SELINUX
> check for .so with its process transaction policy ?

LSM should not need to be updated with this patch series.  However,
systems/components/containers enabling this new check should make sure
it works with their current policy.

> 
> [1] https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/3834992
> 
> -Jeff
> 
> 
> > Usually, that does not include the maim program, but this can
> > happen with explicit loader invocations (“ld.so /bin/true”).
> >
> > Thanks,
> > Florian
> >

