Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920641BCF52
	for <lists+linux-api@lfdr.de>; Wed, 29 Apr 2020 00:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgD1WCI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 Apr 2020 18:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726386AbgD1WCH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 Apr 2020 18:02:07 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A643FC03C1AE
        for <linux-api@vger.kernel.org>; Tue, 28 Apr 2020 15:02:06 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id f18so439269lja.13
        for <linux-api@vger.kernel.org>; Tue, 28 Apr 2020 15:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qgsuGKbVjYSeRuT0TDuIXexAYzlpaF3ybirX/bZdq/M=;
        b=Nb6/Li2pKgIuauzZc2N7D4986KwsAReiq+tNfzAVNQVdh/FoY66ln1u7c/OYs5nAIQ
         5UN/eOvHcUkIcP4q9blPXT94fH+WWdxswwCB5DKULdEHPi1YqR1dvk2z6PvlWWeAQAcm
         wQwwSDA8HHbq+YgMhNTWRBM/CImHC0LY9UotCwM0UgXh0tABr3MbTh+50pfQ0KbVJKi8
         cg4w5xhIpzuG6Bd892VjlS1HnODoa4vjODLOrKsg/dV5ZzXRX6o13x78TwXT7LaG0BJE
         xgEIremOXnl4KN3PAUhl/lbPEuA27Zm/tMJk1F0bDyX0J3fzcmWjvKcuxbldGRhUrvwA
         AVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qgsuGKbVjYSeRuT0TDuIXexAYzlpaF3ybirX/bZdq/M=;
        b=ktrpfcIZ+Coiz1CipfGt22I3CpYYMSE/uFsG7ZbAAH0QUBsMcFV3ccI+9XFCqB3vR6
         04x53lL5tq/ThPSrH1lPaeQj29E7DYUWu5mgubVms56oSkK58P+CZYjIb+WOV/g1Nhbv
         5mAKD0p8/ZEUyXaimuhjdSP9hHa7gVuBBv06GaL6L0SjlfPbZuMuedXxPk29WM1kFoX7
         ZUrREHgFLNpGW69aDbb3TyMH8JD/0TJ+/wufgYR+JovkEt7qKg57bNi4tlLVbaLWqY0S
         Ybu3IkF1BWubvMk8TBJRhtCM2UxI8UPVpKjvwU+UCRA/EYx772mdIq2utPZmF+Xsno6F
         +H/w==
X-Gm-Message-State: AGi0PuYMNWq0pZTi6Bj8q9dmQk/mFXUwNM5EK0Fy7PC5+z36CAGYburC
        6gbh+K6Hll7046V6i1SNtTg8S/MONdGKsnRQztLDLA==
X-Google-Smtp-Source: APiQypK6ydV759YI7StmjgOVJfSU2MfnmxevWP+lyXRgv9iMHdwfQp34+B8t21gh6ZdagByaUv/XhQqYXuOXjfVzfUY=
X-Received: by 2002:a2e:b249:: with SMTP id n9mr18998872ljm.221.1588111324730;
 Tue, 28 Apr 2020 15:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200428175129.634352-1-mic@digikod.net> <CAG48ez1bKzh1YvbD_Lcg0AbMCH_cdZmrRRumU7UCJL=qPwNFpQ@mail.gmail.com>
 <87blnb48a3.fsf@mid.deneb.enyo.de>
In-Reply-To: <87blnb48a3.fsf@mid.deneb.enyo.de>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 29 Apr 2020 00:01:38 +0200
Message-ID: <CAG48ez2TphTj-VdDaSjvnr0Q8BhNmT3n86xYz4bF3wRJmAMsMw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Add support for RESOLVE_MAYEXEC
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Philippe_Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Apr 28, 2020 at 11:21 PM Florian Weimer <fw@deneb.enyo.de> wrote:
> * Jann Horn:
>
> > Just as a comment: You'd probably also have to use RESOLVE_MAYEXEC in
> > the dynamic linker.
>
> Absolutely.  In typical configurations, the kernel does not enforce
> that executable mappings must be backed by files which are executable.
> It's most obvious with using an explicit loader invocation to run
> executables on noexec mounts.  RESOLVE_MAYEXEC is much more useful
> than trying to reimplement the kernel permission checks (or what some
> believe they should be) in userspace.

Oh, good point.

That actually seems like something Micka=C3=ABl could add to his series? If
someone turns on that knob for "When an interpreter wants to execute
something, enforce that we have execute access to it", they probably
also don't want it to be possible to just map files as executable? So
perhaps when that flag is on, the kernel should either refuse to map
anything as executable if it wasn't opened with RESOLVE_MAYEXEC or
(less strict) if RESOLVE_MAYEXEC wasn't used, print a warning, then
check whether the file is executable and bail out if not?

A configuration where interpreters verify that scripts are executable,
but other things can just mmap executable pages, seems kinda
inconsistent...
