Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA1712D3C6
	for <lists+linux-api@lfdr.de>; Mon, 30 Dec 2019 20:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfL3TPW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Dec 2019 14:15:22 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46772 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfL3TPW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Dec 2019 14:15:22 -0500
Received: by mail-ed1-f67.google.com with SMTP id m8so33580072edi.13
        for <linux-api@vger.kernel.org>; Mon, 30 Dec 2019 11:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZmjrGhb+wuiGVK6bOKXUfEcUa7KlDxwgv8e6fd+fEtI=;
        b=R5b9HstpwDK6KvfnJLkNr4KxEgBvgJWFezGyxEVM1/JaRLCRptf9hokCACxVV4ucqZ
         Ge8nllcRFLd7LuS6s0ynOAgl0UWk5ZAGfrHhuvsO+9b4OqRUCyjiS93S9byKtkCKq1Gm
         mG3jN1qMfq8sEykrTJq7CjMphgXQbvV7o78Is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZmjrGhb+wuiGVK6bOKXUfEcUa7KlDxwgv8e6fd+fEtI=;
        b=gjBDD8nfSeYsoP2PbLZSp49lCFRP2341hg0r7XCJz99mG5C3cXgZ+ppzSgdzhY1eM7
         8qk1cVLxU3BqHF8yL3WfySzv9QjpcAJQkn0sydO92OiXaQfDIdUWiUv+65U3fEbT9VWk
         5G6lFvZQ472WdC7vYqL4Kq6ZBZVLjIv4G6av8oZAspktcgUKtyvo2oUnDLljAWwPlGb6
         qKBnzTCtgEfSqnz/5ZNbYDbi/qr8NMJugHrB5FY87O4MVxTlE+U/z+gf5huoCj+aMLfW
         tzJgwW6ezbqd6RVY3M1XcZpFjAO3OD3bCRqswyyBnTh7+jPWp3JOKkeaTGX1TCpTmhnv
         0vSA==
X-Gm-Message-State: APjAAAWOM0zPB9y3RUdA0yJP5uAKy6g4UlHhMAh24gAWAw6EeWoPW65v
        qruMlypP51iSlNbSYRSDw/hRgi8MavRz8dbubwkoJA==
X-Google-Smtp-Source: APXvYqxw0zHopdQJLkfLOLERsk50/sjepInnBW8P9qW3tmZKHs8MTMCQB6TTPwY7HCuAib3phQnoTZi9LjbpQZMxBGc=
X-Received: by 2002:a05:6402:c9c:: with SMTP id cm28mr72516280edb.88.1577733319891;
 Mon, 30 Dec 2019 11:15:19 -0800 (PST)
MIME-Version: 1.0
References: <20191228014837.GA31774@ircssh-2.c.rugged-nimbus-611.internal>
 <20191228181825.GB6746@cisco> <CAMp4zn91GoB=1eTbc_ux4eNs2-QFm+JocodgFQYUiiXL7H4m9w@mail.gmail.com>
 <20191229001818.GC6746@cisco>
In-Reply-To: <20191229001818.GC6746@cisco>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Mon, 30 Dec 2019 11:14:44 -0800
Message-ID: <CAMp4zn9s1wJyb9xHj4xYL5HTtM=gA07ZfBGTSW5j4ayUzaoZNQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] samples, selftests/seccomp: Zero out seccomp_notif
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Dec 28, 2019 at 4:18 PM Tycho Andersen <tycho@tycho.ws> wrote:
>
> On Sat, Dec 28, 2019 at 07:10:29PM -0500, Sargun Dhillon wrote:
> > On Sat, Dec 28, 2019 at 1:18 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > >
> > >
> > > I know it's unrelated, but it's probably worth sending a patch to fix
> > > this to be sizes.seccomp_notif_resp instead of sizeof(*resp), since if
> > > the kernel is older this will over-zero things. I can do that, or you
> > > can add the patch to this series, just let me know which.
> >
> > I was thinking about this, and initially, I chose to make the smaller
> > change. I think it might make more sense to combine the patch,
> > given that the memset behaviour is "incorrect" if we do it based on
> > sizeof(*req), or sizeof(*resp).
> >
> > I'll go ahead and respin this patch with the change to call memset
> > based on sizes.
>
> I think it would be good to keep it as a separate patch, since it's an
> unrelated bug fix. That way if we have to revert these because of some
> breakage, we won't lose the fix.
>
> Cheers,
>
> Tycho

As I was doing this, I noticed that the self-tests all use hard-coded struct
sizes. When I was playing with extending the API, all of a sudden all the
self-tests started failing (until I recompiled them against newer headers).

Should we also change the self-tests to operate against the seccomp
sizes API, or was it intentional for the self-tests hard-coded the struct
definitions, and locked to the kernel version?
