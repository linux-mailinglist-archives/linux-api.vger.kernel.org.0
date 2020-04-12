Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E35831A5CF7
	for <lists+linux-api@lfdr.de>; Sun, 12 Apr 2020 07:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgDLFwA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 12 Apr 2020 01:52:00 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43905 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgDLFwA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 12 Apr 2020 01:52:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id p6so7699044edu.10;
        Sat, 11 Apr 2020 22:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ZvVvhMi+97aAQQQ0omWL76ZEoxg3l8xtO+7pLWSxqZ0=;
        b=dxvD+xFIIY+oaNVZb4qRC5xHRaa+4jldYpRcm5ErQDuDZNJ/vrfx+4xpeqicBmX1sp
         E4fWWCQd8kBzvjFEudqd5mNjD5wJkQ5gOv0I0/fvaDe/z0lqOaHaa3bzjC8POG7DNWQl
         CU7YPB6dj7W5zr7ad6P9g1/tpbuAFYPlQy7agTcIMLai477QJ3fksol0j7qax6cp7Lyy
         Ow7VnTihYXW/Z0yFOeihV0gm2RAlGhHFCrgk0coPQkHFf+rVAhbpdyzoExuOYFpLa070
         J/mLXud86AricnVHxSyuwbAXpAsOfRYTa9egxnGV7W7HTyr1qYD57VfehUbn+pLo7o/p
         XiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ZvVvhMi+97aAQQQ0omWL76ZEoxg3l8xtO+7pLWSxqZ0=;
        b=OHiHuCK7gko6hRLySbBrDpJ6AKpQo88yWmAfhk2NDKPODGVYriCn9Sd4PEwC1B8U8s
         lbksPZmh2S/8X99Sc8Pz3fz1GQZwOz4n8/ke1bh4/+O/wUxHG9xnHK5EMvWi0o9MJW5n
         pityDx3f93L1XDGdQBJZlbbDDx5ktYVHUDnaJ6XxOp8gSk4j1r+HATyzAVRMrkxuThUF
         KMPtsF3F72iKDUFZE7JOI756RmDZ4wtXO4fMuTsk9oD274hKd/vY58IOvVh0wjh0P0Vb
         W1/l0S5VIiXCIgzbWfvoc/NSjNpJD+ObuOk+i5votnPzkynGP1U1jHq6xO6jVJssmAty
         iojg==
X-Gm-Message-State: AGi0PuYRf6fgKyzyFzEGWOg/3Qt1CQYOcY//Z5P5X2XlVRUl0Sl/x/n6
        vVUahPYS/mJyV6k4X1XC6PGUyhVsqdK+4Qj30Go=
X-Google-Smtp-Source: APiQypLMhQROcmZsDJ+OXaSWdhUvPyQMDyPwXSrE7W/vBSXRpDMROcT/AM0iiw1GNEqnG/O+1He0+fnq9kOuIqQ9SUA=
X-Received: by 2002:a05:6402:1485:: with SMTP id e5mr11519371edv.239.1586670718669;
 Sat, 11 Apr 2020 22:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <96bedbaf-49ea-f24b-b7b1-fb9a57fb6c7d@gmail.com> <20200411154031.642557-1-avagin@gmail.com>
In-Reply-To: <20200411154031.642557-1-avagin@gmail.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Sun, 12 Apr 2020 07:51:47 +0200
Message-ID: <CAKgNAki6uBHVTBdJvj7hzbho9Z94MWRV7ab8npduogQohRndBQ@mail.gmail.com>
Subject: Re: [PATCH v2] timens: show clock symbolic names in /proc/pid/timens_offsets
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Andrei,

On Sat, 11 Apr 2020 at 17:40, Andrei Vagin <avagin@gmail.com> wrote:
>
> Michael Kerrisk suggested to replace numeric clock IDs on symbolic
> names.
>
> Now the content of these files looks like this:
> $ cat /proc/774/timens_offsets
> monotonic      864000         0
> boottime      1728000         0

Thanks.

Assuming no-one has objections to the patch, please do mark for stable@.

Cheers,

Michael
