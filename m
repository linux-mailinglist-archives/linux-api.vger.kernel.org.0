Return-Path: <linux-api+bounces-2130-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6BE948787
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2024 04:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04351F23A26
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2024 02:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AD13A1CD;
	Tue,  6 Aug 2024 02:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R3QIeRN8"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F5D383A5
	for <linux-api@vger.kernel.org>; Tue,  6 Aug 2024 02:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910942; cv=none; b=IsDCdUiWcQhCFYYwm8XwJW6hy5AXjwn0/ohmFcCGCHg4L/NzsQ2D20izjKsDNAWaK0U76Ma9OTeQ5/gXIbsrhyVRRPiRUlra1LAYD1Ga0zoK9WyjblKEbuAlhF+nPzjtXSQ18JvR94ek+uYmZNJqX5P4iHzyFUj67/RstEtYDIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910942; c=relaxed/simple;
	bh=a9Vp+4x2A4ioCvdcdJD7sOUfBOazJEHoNcUHQ9qx7zA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ItNUndgSfyIsf3gIa57Ni4Wmfn2+/JX5LbpW8F0IpzMys4b5LDmYCGSX9Zwwt+gzj53QFeyy2kBQ7jRNE288KaZBDLxU7vX4Pcu3j9In3mpoe1eI9+kuQqBD39r0PLFnygyt98Ic8RG08PWxXhO0wsjzsZXPlPz3vgPCV5lxNpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=R3QIeRN8; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7aa4ca9d72so4204366b.0
        for <linux-api@vger.kernel.org>; Mon, 05 Aug 2024 19:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722910939; x=1723515739; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LIFbxMpiXxHdMqbCN+3/gUCx3hbdMfLnZFy+ZXlHFxY=;
        b=R3QIeRN8R1xpdz732kjD6S6U2F7ydO7BX9fUykDsYkeZkSwsQpg7G+JoLtbr+HMbg0
         14YSiTSb4v7B4zn6c2NMDjj0bdAsNWXqqo4ekxehMNaKbZOYxQch8HOdcNX86twrPz0+
         73eg8CayzRhKKmwfgIh+BE2kBEtYEIWxzvwO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722910939; x=1723515739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LIFbxMpiXxHdMqbCN+3/gUCx3hbdMfLnZFy+ZXlHFxY=;
        b=TQZrxrGfXCU47H56Q+GtBJc9zdQo3VYcExpKQbsPq0ZvE+oh0JxF4yrlK9bAJ6Iccn
         qzMtYhbC4Jv4lzNamYaQmY94xZS9iuO4/M81fdpvtAiWy/e3QGBvX3b+/uJiTJiWjIr3
         xOpM38z0zdyMWARDCmJpnuVvn8Y2NgMxsGrZb5JMfMTs6DbaddNeWGdbSLz2sN/iNkj0
         PVCqVGe2opVL91A0of6HjzGqCPSorUD+c7goa7bPUpgjdmozM+Zeg8cpz09lu1cvs5fN
         ykHdEafol/vom0IO+xq71sTBFNfUMoENBLO6k6Y/IZ0HBB2JE4oXPJZyEGgafAkZtJQR
         aubQ==
X-Forwarded-Encrypted: i=1; AJvYcCViobvxrsF+vHkxPsPsx8xBwmBQSvHbeo0SihrIBOiM6x9N9zvtX1f8y82MMPGRVXwQ085mvCWkorgJX+Iudn2ZclvEavzj9wt9
X-Gm-Message-State: AOJu0Yzr2gpTgNf+cFfgcDw++xVd4R7IMSQANaN8eTHj2ORSYNnic0yj
	6Dl2t4vpIF2yX/Jbuc2DRgcv9cpc0+SLQjnx4URCyXMaEGrloBFy2gcXNMsvZ4ZoErC+ZJ1GfcL
	Q+3gbzA==
X-Google-Smtp-Source: AGHT+IHEjvyrfI7IvpKCF6Xt9CwjGQda/V4kfgOPfq1wLWYTKpnNSJSss/4ZHXQF8F+LOczDTQhkBg==
X-Received: by 2002:a17:907:1c19:b0:a7a:8876:4429 with SMTP id a640c23a62f3a-a7dc506f5aamr1156554166b.45.1722910939359;
        Mon, 05 Aug 2024 19:22:19 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c614ecsm504979666b.93.2024.08.05.19.22.18
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 19:22:19 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso467875e9.1
        for <linux-api@vger.kernel.org>; Mon, 05 Aug 2024 19:22:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXBrSUvYXeNUJSl6eTiVhp6mZM+jfCmVEcZJstm1lE0ZjVe9tNcIMXPY7guCZv6/S74zwnUFGw03KRCLe/3ldnuzVldz3dG3R0R
X-Received: by 2002:aa7:cb43:0:b0:5aa:19b1:ffde with SMTP id
 4fb4d7f45d1cf-5b7f59e20a8mr9459334a12.34.1722910549350; Mon, 05 Aug 2024
 19:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202408041602.caa0372-oliver.sang@intel.com> <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
 <CAKbZUD3B03Zjex4STW8J_1VJhpsYb=1mnZL2-vSaW-CaZdzLiA@mail.gmail.com>
 <CALmYWFuXVCvAfrcDOCAR72z2_rmnm09QeVVqdhzqjF-fZ9ndUA@mail.gmail.com>
 <CAHk-=wgPHCJ0vZMfEP50VPjSVi-CzL0fhTGXgNLQn=Pp9W0DVA@mail.gmail.com>
 <CALmYWFuCvphvLQOuQHBbFq0G8Ekyze=q45Tt4dATOt-GhO2RGg@mail.gmail.com>
 <CAHk-=wgySgXXkZtx49Xq70X2CmSizM8siacYKncMmFWRzKjs5Q@mail.gmail.com>
 <D38D6LJZOIQK.2GV58PGVL5K85@gmail.com> <CAHk-=wjeWqr+0Ktzbwqrw17aESe5dZm5Kt6nwqtKJX00VsDqWg@mail.gmail.com>
 <87r0b2if4t.fsf@mail.lhotse>
In-Reply-To: <87r0b2if4t.fsf@mail.lhotse>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Aug 2024 19:15:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibKvw92keueGCUpr428BvhgEwoJxXow2NyBq2LiRGhFw@mail.gmail.com>
Message-ID: <CAHk-=wibKvw92keueGCUpr428BvhgEwoJxXow2NyBq2LiRGhFw@mail.gmail.com>
Subject: Re: [linus:master] [mseal] 8be7258aad: stress-ng.pagemove.page_remaps_per_sec
 -4.4% regression
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, Jeff Xu <jeffxu@google.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Pedro Falcato <pedro.falcato@gmail.com>, 
	kernel test robot <oliver.sang@intel.com>, Jeff Xu <jeffxu@chromium.org>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Dave Hansen <dave.hansen@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <groeck@chromium.org>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Amer Al Shanawany <amer.shanawany@gmail.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	linux-api@vger.kernel.org, linux-mm@kvack.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Aug 2024 at 19:01, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> >
> > I just don't quite know _why_ powerpc cares.
>
> AFAIK for CRIU the problem is signal delivery:

Hmm. Well, the patch I sent out should keep it all working.

In fact, to some degree it would make it much more straightforward for
other architectures to do the same thing.

Instead of a random "arch_munmap()" hack, it's a fairly reasonable
_install_special_mapping() extension.

That said, the *other* thing I don't really understand is the strange
"we have to set the context.vdso value before calling
install_special_mapping":

        /*
         * Put vDSO base into mm struct. We need to do this before calling
         * install_special_mapping or the perf counter mmap tracking code
         * will fail to recognise it as a vDSO.
         */

and that looks odd too.

Anyway, I wish we could just get rid of all the horrible signal restore crap.

We used to just put it in the stack, and that worked really well apart
from the whole WX thing.

I wonder if we should just go back to that, and turn the resulting
"page fault due to non-executable stack" into a "sigreturn system
call".

And yes, SA_RESTORER is the right thing. It's basically just user
space telling us where it is. And happily, on x86-64 we just forced
the issue, and we do

        /* x86-64 should always use SA_RESTORER. */
        if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
                return -EFAULT;

so you literally cannot have signals without it.

             Linus

