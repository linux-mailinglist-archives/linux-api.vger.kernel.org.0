Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A268B1A0941
	for <lists+linux-api@lfdr.de>; Tue,  7 Apr 2020 10:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgDGIW7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Apr 2020 04:22:59 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43675 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgDGIW6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Apr 2020 04:22:58 -0400
Received: by mail-ed1-f66.google.com with SMTP id bd14so2919770edb.10;
        Tue, 07 Apr 2020 01:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ejAayTcXYcOvuq76wvJxUyJSQiYoHi/FdRj1wkyhmmE=;
        b=bicuuoX8EsqEhTkv2MDMYFT4t3rRbo86omOXZJ8OPWCrG1PhsPSvrgIgKsD9bfuHPO
         gJtv4BhJL3TdDs+E6FVHeIU7PXRIJV9hBuk+38G3KozPyIkCZiIMGlrNdcNW/tgNVqjU
         oOZldAatdRQJxLuAvHXlC+e31E+SJOUIe0aXHZSor0RvbzM2AUEjR4RrLB8bGHdZ4r2k
         nt5cJORkY98XOBLkeuERwBRoiVjzyEx4HyUQM0Lr+vO/c9UD46WJCCG89HMAZk6g9s/g
         B/d6vbRonWx4X5LuGqfkCYSjwX8HsquBvfH7/fvjrBPBLThw7mZlsQKoAv4OVHmPT0X5
         GwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ejAayTcXYcOvuq76wvJxUyJSQiYoHi/FdRj1wkyhmmE=;
        b=YWsfIkdxw8uXEDJFCI7trcFkBgJvUawMK+rKJurhOZsCgH6f5PqVNry1cIkYV7YABX
         tgya98fM5wx3/YEQUxda6zygV0OfVWgY4DxOIs30gAF+c4J+2sm9WbN94V9bf5aQsA3t
         vE1rmA9meJjD6QL5exfp7iofJPwkeMo1JlesPYZurh/L7pZXX1MR95jq5JIJFBCpk5nH
         +qngA7319+J3GVNCSGaIrOBJiM2GWybhzCBpaHr8sOMs6xSwJjo/YQ9SaO6jLZNLRDn4
         W1VnvbdYZNU0e9sX9U7XDjiFyCG2e/eo2smRn7SGGw8Jv5RPRCtXfiFkHlajpsibugvA
         peXw==
X-Gm-Message-State: AGi0PuZ8WoJ/Z0bOihlEwqCizyEEoZt02ivvQ2IXE2KoxwIy+VkG7tGv
        hkdDpP1WUatnOrPCK6snrtqD9iKvL5T+l+RQe8c=
X-Google-Smtp-Source: APiQypLiWqCoYibx4qvBpJO+la1+IzbhqslVPhv6xA2Nple7IIy7a1xAWP3YLNaFncuGajImOP6UeqL1KNSrtFY5O/g=
X-Received: by 2002:a17:906:1188:: with SMTP id n8mr938773eja.150.1586247775888;
 Tue, 07 Apr 2020 01:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200406171342.128733-1-dima@arista.com> <20200407033148.GB494464@gmail.com>
In-Reply-To: <20200407033148.GB494464@gmail.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Tue, 7 Apr 2020 10:22:45 +0200
Message-ID: <CAKgNAkgTdND5m60Adb2O+SnogcUcho15F9cF5sZt_yrDF0REYg@mail.gmail.com>
Subject: Re: [PATCH] kernel/time: Add max_time_namespaces ucount
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Dmitry Safonov via Containers 
        <containers@lists.linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrey Vagin <avagin@openvz.org>,
        Dmitry Safonov <dima@arista.com>,
        Linux API <linux-api@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>, stable@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Adrian Reber <adrian@lisas.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 7 Apr 2020 at 05:31, Andrei Vagin <avagin@gmail.com> wrote:
>
> On Mon, Apr 06, 2020 at 06:13:42PM +0100, Dmitry Safonov via Containers wrote:
> > Introduce missing time namespaces limit per-userns.
> > Michael noticed that userns limit for number of time namespaces is
> > missing.
> >
> > Furthermore, time namespace introduced UCOUNT_TIME_NAMESPACES, but
> > didn't introduce an array member in user_table[]. It would make array's
> > initialisation OOB write, but by luck the user_table array has
> > an excessive empty member (all accesses to the array are limited with
> > UCOUNT_COUNTS - so it silently reuses the last free member.
> >
> > Fixes user-visible regression: max_inotify_instances by reason of the
> > missing UCOUNT_ENTRY() has limited max number of namespaces instead of
> > the number of inotify instances.
> >
> > Fixes: 769071ac9f20 ("ns: Introduce Time Namespace")
> > Cc: Adrian Reber <adrian@lisas.de>
> > Cc: Andrey Vagin <avagin@openvz.org>
> > Cc: Christian Brauner <christian.brauner@ubuntu.com>
> > Cc: Eric W. Biederman <ebiederm@xmission.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Cc: Containers <containers@lists.linux-foundation.org>
> > Cc: Linux API <linux-api@vger.kernel.org>
> > Cc: stable@kernel.org # v5.6+
> > Reported-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
>
> Acked-by: Andrei Vagin <avagin@gmail.com>

Acked-by: Michael Kerrisk <mtk.manpages@gmail.com>



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
