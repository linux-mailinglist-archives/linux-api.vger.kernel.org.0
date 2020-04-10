Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2E7C1A423A
	for <lists+linux-api@lfdr.de>; Fri, 10 Apr 2020 07:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgDJFYF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Fri, 10 Apr 2020 01:24:05 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42940 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgDJFYF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Apr 2020 01:24:05 -0400
Received: by mail-ot1-f65.google.com with SMTP id j20so183518otl.9;
        Thu, 09 Apr 2020 22:24:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G7Vs6kbIU7vDoe0PVtVhOXYoT49lemDbcQnLgW0gxPY=;
        b=so8FAPcR1CMo+/j4f39k765yjz6XskK4I3NVUgyEHYwGN5YNTekFPNcz14Jou3Un62
         tFnG9pXrujpeplebshGhRKOQEA0LiP2m9vo3TRDa08NT4es9zRpzXBPKBue2yUayy+yF
         A53nVAaRFaji02dXGp5YX5V/FLOsnWh6YAxGwpimX4HFMOujoiEB9Wy4Zh7of4JhPYjF
         ADK8PoRljqLGcAICa36MbiIzzL1Ynj8EZklEUz1CPL4i/XKEHneH0to/nfhf2bdkwyGw
         AECC+WGn9+3kOtSM30t8zEY9TfUEz/pxPn0c/DuzGqTFBYTwdGtp73rASDh298aJ+zm4
         l93w==
X-Gm-Message-State: AGi0PuaGBWJLxlP6omLfY8fYsIuw0/mU1yJVjFEdsSHREU54hE44HBam
        Ky5R7luNA3PyF6xaUMAJtTACuPqh2aaq7QItbQw=
X-Google-Smtp-Source: APiQypI0vs7WpqePP2PloLl2p5qMbNw++RNcXkUrcByTbojM92sZ4ZvW8TPwDaJ3eAYzfjx2GHuD0QSZavcCS4qkIsY=
X-Received: by 2002:a4a:c595:: with SMTP id x21mr2952338oop.10.1586496244370;
 Thu, 09 Apr 2020 22:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <703440af-031c-16b5-c1ff-54fb4bb5e10c@gmail.com>
 <CANaxB-y0ZB223dQgvxvUHRzkn4f-_B2vTzYxe_mi=o+3SJ4yVw@mail.gmail.com> <87a73kny56.fsf@x220.int.ebiederm.org>
In-Reply-To: <87a73kny56.fsf@x220.int.ebiederm.org>
From:   Andrey Vagin <avagin@openvz.org>
Date:   Thu, 9 Apr 2020 22:23:49 -0700
Message-ID: <CANaxB-y2wWz9tnpoKfvoSOGW=WxeNkSgX+bvsFQO_79JqYMsZw@mail.gmail.com>
Subject: Re: A further though on /proc/PID/timens_offsets
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Dmitry Safonov <dima@arista.com>,
        Linux API <linux-api@vger.kernel.org>,
        Containers <containers@lists.linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Adrian Reber <adrian@lisas.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Apr 9, 2020 at 2:35 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Andrey Vagin <avagin@openvz.org> writes:
>
> > On Tue, Apr 7, 2020 at 6:24 AM Michael Kerrisk (man-pages)
> > <mtk.manpages@gmail.com> wrote:
> >
> >>        The  clock-id  identifies the clock whose offsets are being shown.
> >>        This field is either 1, for CLOCK_MONOTONIC, or 7, for CLOCK_BOOT‐
> >>        TIME.
> >>
> >> What was the reason for exposing numeric clock IDs in the
> >> timens_offsets file? In API terms, that seems a little ugly.
> >>
> >> I think it would have been much nicer if the clocks were defined
> >> symbolically in this file. I.e., that reading the file would have
> >> shown something like
> >>
> >> monotonic    x    y
> >> boottime     x    y
> >>
> >> And that records similarly with symbolic clock names could have
> >> been written to the file. Was there a reason not to do this?
> >
> > No, there was not except that I haven't thought about this. I agree
> > that symbolic clock names looks nicer for humans, but numeric clock
> > IDs are a bit more convenient when we  need to set/read offsets from
> > code. This interface is in the released kernel, so I think we can't
> > change the format of the content of this file. But we can add support
> > of symbolic clock names for setting clock offsets. What do you think?
>
> The rule is we can change things as long as userspace doesn't care.  For
> very new interfaces like this it is possible there are few enough
> userspace programs that nothing cares.
>
> Do you know if someone is using this interface yet?

CRIU has the support of time namespace, but these changes are in the
devel branch and have not been released yet.

I know two more project:
* The util-linux (unshare and nsenter tools):
https://github.com/karelzak/util-linux/commit/7f1f0584c24a77909a7c96e62e30f63f4c1b10ad
https://github.com/karelzak/util-linux/commit/ef0341c9be441b834848d260ba0dbeb47a20f7a3

The last release of util-linux was at the end of January, so these
changes have not been released.

* crun
https://github.com/containers/crun/commit/a669dc64f70f71423a0ee1bb977f2d77e473649a

These changes have been released in the crun v0.13.

All these projects only set offsets, so I think following the rule
that you described, we can start showing symbolic clock names and
accept both variants for setting offsets. If everyone agrees with
this, I can prepare a patch tomorrow.

Thanks,
Andrei
