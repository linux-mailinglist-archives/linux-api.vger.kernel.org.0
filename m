Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D652D65EE
	for <lists+linux-api@lfdr.de>; Mon, 14 Oct 2019 17:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733243AbfJNPK3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 14 Oct 2019 11:10:29 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46372 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732647AbfJNPK2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 14 Oct 2019 11:10:28 -0400
Received: by mail-oi1-f194.google.com with SMTP id k25so13995038oiw.13
        for <linux-api@vger.kernel.org>; Mon, 14 Oct 2019 08:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n8mZzQYgCJoh/U/LtDTWoqHWL38rFTI9nqBb83t1F0I=;
        b=eL0KkC/qG5Sqdy3584kkE+iz33uqISxvsXEGdERUa7Qba35awyW4wPPpCaQDK4Vf1r
         A3DLF2XrRN3Lwh4n2M6qxwxu2T46oy32FbABZOdyiBDH2LNz67ggJr+I5OhDY4eeapth
         bIGYmB1CSf53TZI51DGqJab6Wjwy5z7eYIb7P7XsOHgHr1mbV/Jf08+om+Jr88+Wba5R
         oTzg3htSuDlhpSRZS3B1U76DkyOGgI+M99HxgN9w9xoR6tCXMFWhLG44qctxm9vFjIrm
         5i5FtAqJuGamLA8VvOY1RqJRFB8jEkEhrNIziL8n1p3hBxPQloscS8mtFR/Ak1n5qkBB
         6+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n8mZzQYgCJoh/U/LtDTWoqHWL38rFTI9nqBb83t1F0I=;
        b=Jbtr5GzbfXI1OC4iZ50f3fuhpv107H9V2n0MRqG3MwKxcSdlvFSVYAQr4LssASou/+
         9V+HVsmVaoIuBLDhLMIH//0Drkdg9f5b/S5t0wmSZlYuWyOCrpf+I/3EysG7EXZuFWSK
         JwVU1yVQJSRK7dCpV4tSf/uWIXGNcVVh3HEzHwZgq2ObQOZPqoTZKuxF5VNSNQG3Sfba
         ZojIvs/v4Chb2aj6S8S8DlM8QqTAX99lSByy32vdkhi4vLpQW6rIu3O4lNWvA7snoLHD
         SsgiCfA1Xmz55qcVZzspIRyGTLJCfzKSXqAWIdRp7Y3d3eRdwUZp/VwYEGYxJPjW+Zy9
         wSbw==
X-Gm-Message-State: APjAAAXTmmRwXD8srwNflsA4rZaJJ8pbMdRTpv45iLB15kS/2RzyfxB1
        p9qhMFHkKHbooOu+vtVqnRdFau3Q4FN/8iYJzdrXZw==
X-Google-Smtp-Source: APXvYqzcVFFImqZI58K41aEG21TM6C60Hd0B7GL6/+3YeLE94vV5SzMbABckyJbt3DVKWbg2bM0mT6UlrjQp+Ume+Q4=
X-Received: by 2002:a05:6808:95:: with SMTP id s21mr25075773oic.68.1571065827544;
 Mon, 14 Oct 2019 08:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez1hk9d-qAPcRy9QOgNuO8u3Y_hu_3=GZoFYLY+oMdo8xg@mail.gmail.com>
 <20191012101922.24168-1-christian.brauner@ubuntu.com> <20191012102119.qq2adlnxjxrkslca@wittgenstein>
 <abc477fb3bd8fbf7b4d7e53d079dd1d8902e54af.camel@kellner.me> <20191014103157.h2wph2ujjidsrhyw@wittgenstein>
In-Reply-To: <20191014103157.h2wph2ujjidsrhyw@wittgenstein>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 14 Oct 2019 17:10:01 +0200
Message-ID: <CAG48ez1Yf05j2irdZxT2TA=2n3xo25KN48nRQdp_F8j14K36rA@mail.gmail.com>
Subject: Re: [PATCH] pidfd: add NSpid entries to fdinfo
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christian Kellner <christian@kellner.me>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Roman Gushchin <guro@fb.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Oct 14, 2019 at 12:32 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> On Mon, Oct 14, 2019 at 11:43:01AM +0200, Christian Kellner wrote:
> > On Sat, 2019-10-12 at 12:21 +0200, Christian Brauner wrote:
> > > I tried to think of cases where the first entry of Pid is not
> > > identical
> > > to the first entry of NSpid but I came up with none. Maybe you do,
> > > Jann?
> > Yeah, I don't think that can be the case. By looking at the source of
> > 'pid_nr_ns(pid, ns)' a non-zero return means that a) 'pid' valid, ie.
> > non-null and b) 'ns' is in the pid namespace hierarchy of 'pid' (at
> > pid->level, i.e. "pid->numbers[ns->level].ns == ns").

Agreed.

> You could probably do:
>
> #ifdef CONFIG_PID_NS
> seq_put_decimal_ull(m, "\nNSpid:\t", nr);
> for (i = ns->level + 1; i <= pid->level && nr; i++)
>         seq_put_decimal_ull(m, "\t", pid->numbers[i].nr);
> #endif

Personally, I dislike hiding the precondition for running the loop in
the loop statement like that. While it makes the code more concise, it
somewhat obfuscates the high-level logic at a first glance.
