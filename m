Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64134139A0E
	for <lists+linux-api@lfdr.de>; Mon, 13 Jan 2020 20:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgAMTTC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Jan 2020 14:19:02 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33034 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgAMTTB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Jan 2020 14:19:01 -0500
Received: by mail-ot1-f65.google.com with SMTP id b18so10079367otp.0
        for <linux-api@vger.kernel.org>; Mon, 13 Jan 2020 11:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NoYTay9gEdUwJzd8flck47gwEsidyqOErVEeC39Jq2o=;
        b=PWAQO6n8uYq2a4CdtE53n1PqHPbBvA3iHygW7xlF/mSri9aldE4CMUkmnObd7hvGs+
         XD3R1Xw11ZzgSnhSmK2jiytZo/UPfvHdS8pHGjOXyjnUpk963f33BYXN60mn6ZimSH7g
         iiZRP7Sm1suyhXpkmTz0ed2tCy9XjdSobgkM3xuDVIL8GV5mRpPyinERHpcyJgDMCaIn
         j+f26vKogVX03oygCZPnkb35fMmNiERhbVQNmh0mCoevC5PTlQTz2jgggfS3utSfwGla
         fT5WYAnROxmU06T+LAPng4nnHMe9Zi4KN5FYNFewShO4WtQI1iD4Zd5FGjZ8i9u1WEvK
         +kDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NoYTay9gEdUwJzd8flck47gwEsidyqOErVEeC39Jq2o=;
        b=hfy8I74e9+NvDwcQxfS0UhQKRf64MCQrgcJNURlm5Iaju6KBsi9qeB7zaLW4G4lUxK
         WvJ6tz+wMVktYSuR2+f/kjxtoS8j+dUAto7k5/ZxKckjrL+Be78jZgEQH/wvW97qrerM
         HvWngRX+t0X2HyexfQjBA6+GwQ/F8mbYKLcqHs26hkqAbPyOuv/X/srXj2YrgeuHNdoQ
         PtUU7L7T6lzYquwOV0soTvN065WKQb3E9wg6cs9mSADF4rHehUluoRbXseH/UNMS3AdH
         61xfpK5DMQ+RdWUhJg57ZZj8sHYFwx4fg5GX8aJkdrFg3r+5sMR29KElnLMW8/eK53Lc
         H9Hw==
X-Gm-Message-State: APjAAAUVplfX4UUO4y6zyPnzEpZIwoRp2yMSVGKm4lwxCFIPBjRPdwqG
        vr//dF8qIRqZpEhLVcEM3RFCrS4++Bvy7fXqoNSong==
X-Google-Smtp-Source: APXvYqwzd6z4BsjCgwUlGC6h2jl1N7nb469FD4i67Yk4Xbt8zlAhmtvz3QdfKHsOBvBT2VACljpoCk6xfa7vX5xy6N0=
X-Received: by 2002:a9d:2028:: with SMTP id n37mr14712535ota.127.1578943140656;
 Mon, 13 Jan 2020 11:19:00 -0800 (PST)
MIME-Version: 1.0
References: <20200110213433.94739-1-minchan@kernel.org> <20200110213433.94739-3-minchan@kernel.org>
 <56ea0927-ad2e-3fbd-3366-3813330f6cec@virtuozzo.com>
In-Reply-To: <56ea0927-ad2e-3fbd-3366-3813330f6cec@virtuozzo.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 13 Jan 2020 11:18:23 -0800
Message-ID: <CAKOZuevwbQvrFWqy5GOm4RXuGszKLBvRs9i-KbAi3nPcHhwvSw@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm: introduce external memory hinting API
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>, oleksandr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jan 13, 2020, 12:47 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> > +SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
> > +             size_t, len_in, int, behavior, unsigned long, flags)
>
> I don't like the interface. The fact we have pidfd does not mean,
> we have to use it for new syscalls always. A user may want to set
> madvise for specific pid from console and pass pid as argument.
> pidfd would be an overkill in this case.
> We usually call "kill -9 pid" from console. Why shouldn't process_madvise()
> allow this?

All new APIs should use pidfds: they're better than numeric PIDs in
every way. If a program wants to allow users to specify processes by
numeric PID, it can parse that numeric PID, open the corresponding
pidfd, and then use that pidfd with whatever system call it wants.
It's not necessary to support numeric PIDs at the system call level to
allow a console program to identify a process by numeric PID.
