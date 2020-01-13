Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 028B8139B16
	for <lists+linux-api@lfdr.de>; Mon, 13 Jan 2020 22:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgAMVFY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Jan 2020 16:05:24 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43501 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgAMVFY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Jan 2020 16:05:24 -0500
Received: by mail-lj1-f194.google.com with SMTP id a13so11724105ljm.10
        for <linux-api@vger.kernel.org>; Mon, 13 Jan 2020 13:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/u5MUGVpDUAbfDbLeEsPX6aUptgWMsZ6OpMkOdaH+A4=;
        b=pywZLKqdxPfExS0SnABaJ4aTlQdAJxvMIPcUiv09kBnxMbRddIefk6L+AZtCxKjWgA
         liHsrkFRC3T9RBzdlmOhUVoaEwJ5JAUBmXvh78E0up26nPZ4ijaFW8mUbjAFWyB2kxi1
         edgeWwJ3faA3x9NLcDaEa0gXbEXEgCF6iZ12xGf4x2B1oR62JNenKpXiDsinOqybcBL/
         5z60/LxPmvRsfacCOOyvejl2NFaOXDPWX6k8QKvbmBf8vjXLe2Nc/I6MAqALAeeOUOB3
         5OC/2iiijXYynwhr1LtgfBkelfr6L54T3rAd02/rrhUTlSv2CTl04r7b6+dIP+dzetEf
         HUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/u5MUGVpDUAbfDbLeEsPX6aUptgWMsZ6OpMkOdaH+A4=;
        b=pEBrh6chDx91Z8GRYinBfwodWlv6E4fLViYbu3I9U5Yi81/zH2Oxnt0VoF6ZnM1sWS
         y/nG6RvaOqgLEbIGqY+RLj3aE7DZKhhMTXbdZF0UtlpgWeiwNLLWtvldobNY4ClDwyjE
         Dls9ghRx4u3ZTSJNMSsQRIehmPwdz/ybDXvVTSaOhW3PxUmtkZoOvodne0AUWZ1LdDNO
         wCmSjgXDN6H6l886LwWNQXSNdpbtH3nYwhtTXNExV4p/Nz6mwVZDNBslFQk1bgjRt5f+
         aeOpet4GLUoyEWqtrDt8WAjzKwyEvTfg+5R3hyP8EWCUFQRTeTDg4CB0uUQ/nnNBH7tu
         /uJA==
X-Gm-Message-State: APjAAAWtIfjQepvrAuRjm2C2h50+4IiyPiFbtEEyZn/JR6EnuRA4fIuM
        3Rvx185UcZyDuBq29gj4aepe+W1PtXk6A57+USsVsg==
X-Google-Smtp-Source: APXvYqzQfqC3NRhrk3Zbw6Vxs6CF1OSy/YynDWKFCf4ieKNe8SG3O6+EGYSzBmYNgwrdJR5te76K8Vzy42PCS745ObY=
X-Received: by 2002:a2e:884d:: with SMTP id z13mr12351302ljj.116.1578949522306;
 Mon, 13 Jan 2020 13:05:22 -0800 (PST)
MIME-Version: 1.0
References: <20200110213433.94739-1-minchan@kernel.org> <20200110213433.94739-3-minchan@kernel.org>
 <56ea0927-ad2e-3fbd-3366-3813330f6cec@virtuozzo.com> <20200113104256.5ujbplyec2sk4onn@wittgenstein>
 <20200113184408.GD110363@google.com> <20200113191046.2tidyvc544zvchek@wittgenstein>
 <CAKOZuev5k3EquMd-6VbvruahjjtxQzRhUVo2ttgVyk+yYz9aOA@mail.gmail.com> <20200113204237.ew6nn4ohxu7auw3u@wittgenstein>
In-Reply-To: <20200113204237.ew6nn4ohxu7auw3u@wittgenstein>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 13 Jan 2020 13:04:44 -0800
Message-ID: <CAKOZueu=U4c2URaq8Pz-B00XV+TxaKwHRNXv3BUiDbQrLQpJ3A@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm: introduce external memory hinting API
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>, oleksandr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jan 13, 2020 at 12:42 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Mon, Jan 13, 2020 at 11:27:03AM -0800, Daniel Colascione wrote:
> > On Mon, Jan 13, 2020 at 11:10 AM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > > This does not
> > > affect the permission checking you're performing here.
> >
> > Pidfds-as-capabilities sounds like a good change. Can you clarify what
> > you mean here though? Do you mean that in order to perform some
> > process-directed operation X on process Y, the pidfd passed to X must
> > have been opened with PIDFD_CAP_X *and* the process *using* the pidfds
> > must be able to perform operation X on process Y? Or do pidfds in this
> > model "carry" permissions in the same way that an ordinary file
> > descriptor "carries" the ability to write to a file if it was opened
> > with O_WRONLY even if the FD is passed to a process that couldn't
> > otherwise write to that file? Right now, pidfds are identity-only and
> > always rely on the caller's permissions. I like the capability bit
> > model because it makes pidfds more consistent with other file
> > descriptors and enabled delegation of capabilities across the system.
>
> I'm going back and forth on this. My initial implementation has it that
> you'd need both, PIDFD_FLAG/CAP_X and the process using the pidfd must
> be able to perform the operation X on process Y. The alternative becomes
> tricky for e.g. anything that requires ptrace_may_access() permissions
> such as getting an fd out from another task based on its pidfd and so
> on.

I think the alternative is necessary though. What's the point of the
pidfd capability bits if they don't grant access? If I have a pidfd
for Y that doesn't let me do operation X, but I have ambient authority
to do Y anyway, then I can just make my own pidfd for Y and then use
that new pidfd to do X. AFAICT, pidfd capabilities only do something
when they replace ptrace_may_access and friends for access control.
Otherwise, they seem purely advisory. Am I missing something?
