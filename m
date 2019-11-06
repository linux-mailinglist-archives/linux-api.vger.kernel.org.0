Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C837F183E
	for <lists+linux-api@lfdr.de>; Wed,  6 Nov 2019 15:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfKFOQc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 6 Nov 2019 09:16:32 -0500
Received: from l2mail1.panix.com ([166.84.1.75]:50702 "EHLO l2mail1.panix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727478AbfKFOQb (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 6 Nov 2019 09:16:31 -0500
X-Greylist: delayed 926 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Nov 2019 09:16:30 EST
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by l2mail1.panix.com (Postfix) with ESMTPS id 477Sqj3NDGzFGw;
        Wed,  6 Nov 2019 09:01:05 -0500 (EST)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 477Sqh2bHWz14BZ;
        Wed,  6 Nov 2019 09:01:04 -0500 (EST)
Received: by mail-io1-f51.google.com with SMTP id k1so15264588ioj.6;
        Wed, 06 Nov 2019 06:01:03 -0800 (PST)
X-Gm-Message-State: APjAAAW30bdjrwoPxeQ+iEMF8z1CV67HC3DFxqmDKz/ZNvREcNfUWjOF
        nRA2UU0sLTo0hTmRxJ/RDCtYUe0MXyqs+ilgIds=
X-Google-Smtp-Source: APXvYqyNiiZ980P2aQYdN2JGZ2ay2hIizWuWJTEwXvcdX3q2z/Mm48i+X6g4IkKCzWPTnAKbEi9ZHkCaXH06gLiiYmk=
X-Received: by 2002:a5d:9ecd:: with SMTP id a13mr20356555ioe.270.1573048863570;
 Wed, 06 Nov 2019 06:01:03 -0800 (PST)
MIME-Version: 1.0
References: <20191104002909.25783-1-shawn@git.icu> <87woceslfs.fsf@oldenburg2.str.redhat.com>
 <alpine.DEB.2.21.1911051053470.17054@nanos.tec.linutronix.de>
 <87sgn2skm6.fsf@oldenburg2.str.redhat.com> <alpine.DEB.2.21.1911051253430.17054@nanos.tec.linutronix.de>
 <f11d82f1-1e81-e344-3ad2-76e4cb488a3d@redhat.com> <alpine.DEB.2.21.1911051520090.17054@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1911051520090.17054@nanos.tec.linutronix.de>
From:   Zack Weinberg <zackw@panix.com>
Date:   Wed, 6 Nov 2019 09:00:51 -0500
X-Gmail-Original-Message-ID: <CAKCAbMjYBpTjwyMJkkENps09o4KFoQAb_KOKp4g0BtWUXjYAzQ@mail.gmail.com>
Message-ID: <CAKCAbMjYBpTjwyMJkkENps09o4KFoQAb_KOKp4g0BtWUXjYAzQ@mail.gmail.com>
Subject: Re: [RFC v2 PATCH] futex: extend set_robust_list to allow 2 locking
 ABIs at the same time.
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Carlos O'Donell" <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Shawn Landden <shawn@git.icu>,
        GNU C Library <libc-alpha@sourceware.org>,
        linux-api@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Keith Packard <keithp@keithp.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 5, 2019 at 9:28 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The real issue is that the robust list could be circular by incident or
> malice and there is no way for the kernel to figure that out. That would
> prevent the task from exiting and make it iterate over the list until
> doomsday, i.e. a nice unpriviledged DoS.

Why can't the kernel use the standard tortoise-and-hare algorithm for
detecting circular linked lists here?

zw
