Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDB334F03D
	for <lists+linux-api@lfdr.de>; Tue, 30 Mar 2021 19:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhC3R40 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Tue, 30 Mar 2021 13:56:26 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:37555 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbhC3R4T (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 30 Mar 2021 13:56:19 -0400
Received: by mail-ed1-f44.google.com with SMTP id x21so19224891eds.4;
        Tue, 30 Mar 2021 10:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eD2VmTYsiHmGfgPXc7YnjSan4NfejYpT6i+aQbGS1AQ=;
        b=imV7FOBi9QTMtR4TRBBADOy6MgvOxWcbMoa8tH4fK/T96eYCVZSGql6hBoVanJDqBQ
         djfbbn2nYfD5vii4VhYm/dZkf7zsaxBJzurs8p8/Hrtm2RnceLG5TgmoZHIkAo9nmVV5
         aDXRduKH2UxWDO/FpKavigDj6qRvHok2LrnE7lciedtho31NWjtN+VA4/uz3VvX335TI
         zHy1XoDMcX5WhZ4KztSg4UAxSLdShdxYaG9xXleW9pnulRB8+HFRX30lIv5ZoMU42w+u
         hfKLHhGRC9DZ+WskwQlgq+aQUyfZFnXfH9LRz+iD/mNaGndQS4sa6E741EPeVubQy8+d
         g/VQ==
X-Gm-Message-State: AOAM532ntZLI+7MPaFGebxXPKhIZLEfHJsssVpv72Og1jjnsINbicmWL
        Xc0dtwV50OrdznfdqxnjqiEuy0juPh2ShF1X0q4=
X-Google-Smtp-Source: ABdhPJyAsdrYjDD8h/eNXMBrRBDmmHH2cxBRAmOzZmLIkEc7+VobFc9felwB3YqEx/1FygS/xJ4sZJTVWOzg4owtJq0=
X-Received: by 2002:a05:6402:4245:: with SMTP id g5mr35405148edb.306.1617126978544;
 Tue, 30 Mar 2021 10:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvTdKmQN7dXk7FifOqZRZRrOqOoB_6+VR9ORx_AfZWpVRePdA@mail.gmail.com>
 <D652C16A-5CAC-48DF-B6B3-797DC61BBA30@amacapital.net>
In-Reply-To: <D652C16A-5CAC-48DF-B6B3-797DC61BBA30@amacapital.net>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 30 Mar 2021 13:56:07 -0400
Message-ID: <CAJvTdKnMPedpAQjPNDAibXBHYjLYLoJXNSfnnt9KDgit0jjvoA@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Mar 30, 2021 at 1:06 PM Andy Lutomirski <luto@amacapital.net> wrote:

> > On Mar 30, 2021, at 10:01 AM, Len Brown <lenb@kernel.org> wrote:

> > Is it required (by the "ABI") that a user program has everything
> > on the stack for user-space XSAVE/XRESTOR to get back
> > to the state of the program just before receiving the signal?
>
> The current Linux signal frame format has XSTATE in uncompacted format,
> so everything has to be there.
> Maybe we could have an opt in new signal frame format, but the details would need to be worked out.
>
> It is certainly the case that a signal should be able to be delivered, run “async-signal-safe” code,
> and return, without corrupting register contents.

And so an an acknowledgement:

We can't change the legacy signal stack format without breaking
existing programs.  The legacy is uncompressed XSTATE.  It is a
complete set of architectural state -- everything necessary to
XRESTOR.  Further, the sigreturn flow allows the signal handler to
*change* any of that state, so that it becomes active upon return from
signal.

And a proposal:

Future programs, which know that they don't need the full-blown legacy
signal stack format, can opt-in to a new format.  That new format, can
be minimal (fast) by default.  Perhaps, as Noah suggests, it could
have some sort of mechanism where the program can explicitly select
which state components they would want included on their signal stack,
and restored by sigreturn.

If the new fast-signal format is successful, in a number of years, it
will have spread to have taken over the world.

thoughts?

Len Brown, Intel Open Source Technology Center
