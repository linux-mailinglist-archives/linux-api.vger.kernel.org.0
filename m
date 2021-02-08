Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76121313EBD
	for <lists+linux-api@lfdr.de>; Mon,  8 Feb 2021 20:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236011AbhBHTT4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 8 Feb 2021 14:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbhBHTTq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 8 Feb 2021 14:19:46 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD18C061788
        for <linux-api@vger.kernel.org>; Mon,  8 Feb 2021 11:19:05 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id m20so13824595ilj.13
        for <linux-api@vger.kernel.org>; Mon, 08 Feb 2021 11:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qCfnLupVibojf6p+QXa/fy+jh7kBw6RuWeVeUdTLXwE=;
        b=HlSddigbrczVGSDywCR6eQKGHQukIBzWukt9DJWNVuShmOKJuD68leLbzUJr8L6wyv
         sAL8cMNVIwsZUy4iZy8L3FZNPfaYU73Vap1Zf9+1cI6yC0DIrJSlHYvBwEOZCG3BH36F
         KBfePGV09pLgg1LKYkyWfvVxYcbhv5asBuUvtDJp9Lrs4LmuQX2GJ/TlmyPkq7cK6gTk
         F+n9rgD6IqbMOqM/2ywib2WehuBY8PMwMB47VotdKDNjYl+x6YtLt5h3pgO9fJ2TzXRQ
         RVKe44UQIjtJGGMn3x6+2p66HCRvuueCyWjLr5DFqahiGg1IEnOLaKHV9jovAZnuSJ55
         fWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qCfnLupVibojf6p+QXa/fy+jh7kBw6RuWeVeUdTLXwE=;
        b=MjdAznCA1vK1a9fVX52fiK2bC+UnUdOL03gaQ+DTZPV5p1/62froJclXDz4PPF3DPr
         Sf/7zRRdT7gefxaxqC4ZAQagKx959vPxHFwZ+YgwVqJZnQ313+hrbh+7fUzchVspm6xr
         S4UMGqPLQ8Ae2Q33UKVFda3ZVczuavBgFpTTrcuBCP/aThpxj8tI0D1nToOZyP6TgXvB
         eQ4W5MlR+qA0buLfDpFhkR6G+Zu/T8k7rNOnc5wYTWPJs8zVvbGdNSK5b5+tO/JYE6Bl
         izasMDTtAJ+c4mG+V6tAsL606qCn7zkGn/9n7tDwX5hBmicswqrjlmXhewHUURvprtm7
         nGoA==
X-Gm-Message-State: AOAM530bQAN/aUotnzjG0S/11G/wJf7ONFpYSvgi7jPNSmiQL+HjqTl0
        OOXkxmY6twHfrSyBGxgU02bhWYkSG6n6kSDYIf5W/A==
X-Google-Smtp-Source: ABdhPJxNZLD9lYS+fpPxInJSo2bM0a/KDWCemZds9jS3Kq78Mj/APwEqEMeSlaGMApriaXkdxnHlDCFBH8vE3iC8G4w=
X-Received: by 2002:a05:6e02:1be6:: with SMTP id y6mr16174254ilv.145.1612811944425;
 Mon, 08 Feb 2021 11:19:04 -0800 (PST)
MIME-Version: 1.0
References: <20210201194012.524831-1-avagin@gmail.com> <CABV8kRzg1BaKdAhqXU3hONhfPAHj6Nbw0wLBC1Lo7PN1UA0CoA@mail.gmail.com>
 <20210208183752.GB559391@gmail.com>
In-Reply-To: <20210208183752.GB559391@gmail.com>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Mon, 8 Feb 2021 14:18:28 -0500
Message-ID: <CABV8kRzv54fxjXAvu1e8JYBZ7GQc_G-h7OSDWLCQ3NLA-5Ugug@mail.gmail.com>
Subject: Re: [PATCH 0/3 v2] arm64/ptrace: allow to get all registers on
 syscall traps
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        Anthony Steinhauser <asteinhauser@google.com>,
        Dave Martin <Dave.Martin@arm.com>, Kyle Huey <khuey@pernos.co>,
        "Robert O'Callahan" <roc@pernos.co>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

>
> Could you describe the problem in more details? I wonder whether we have
> the same thing in CRIU...
>

Sure, basically the issue is that orig_x0 gets recorded at the start of the
syscall entry, but is not otherwise part of the ptrace state. It used
to be primarily used for resetting the argument back to its original
value during syscall restarts, but I see it's been expanded slightly
with the user dispatch mechanism (though as far as I can tell
not in a way that interacts with ptrace). Basically the problem
is that if you change the value of x0 during either the ptrace
entry stop or a seccomp stop and then incur a syscall restart,
the syscall will restart with the original x0 rather than with
the modified x0, which may be unexpected. Of course,
relatedly, if you're doing CRIU-like things you can end up
in situations where the future behavior will depend on the
orig_x0 value, which isn't restore-able at the moment. It's
possible to work around all of this by keeping a local copy
of orig_x0 and being very careful with the ptrace traps around
restarts, but getting the logic right is extremely tricky. My
suggestion for what I thought would be reasonable
behavior was:

1. Expose orig_x0 to ptrace
2. Set orig_x0 to x0 and set x0 to -ENOSYS at the start of the syscall
dispatcher
3. Use orig_x0 for syscall arguments/seccomp/restarts

That's basically how rax works on x86_64 and it doesn't
seem to cause major problems (though of course I may
be biased by having x86_64 already work when I started the
aarch64 port). Just the first item would be sufficient of course
for getting rid of most of the bookkeeping. I should also say
that, for us, the ptrace getregs call can be the throughput
limiting operation, so it would be nice if getting the entire
basic register set would only require one syscall. I won't
insist on it, since we do have a solution in place that kinda
works (and only requires the one syscall),
but I thought I'd mention it.

While we're on this topic, and in case it's helpful to anybody,
I should also point out that the order of the ptrace-signal-stop,
vs setup for the syscall restart differs between x86 and
aarch64 (aarch64 sets up the restart first then delivers the
ptrace trap/signal - x86 the other way around). I actually
think the aarch64 behavior is saner here, but I figured I'd
leave this breadcrumb for anybody who's writing a ptracer
and stumbles across this.

Keno
