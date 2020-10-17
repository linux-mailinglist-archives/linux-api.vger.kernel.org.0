Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F112290FDA
	for <lists+linux-api@lfdr.de>; Sat, 17 Oct 2020 08:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436892AbgJQGB4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 17 Oct 2020 02:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436910AbgJQGBl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 17 Oct 2020 02:01:41 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62863C05BD1B
        for <linux-api@vger.kernel.org>; Fri, 16 Oct 2020 21:03:05 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i2so4923537ljg.4
        for <linux-api@vger.kernel.org>; Fri, 16 Oct 2020 21:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uR2yRSoFIyQFa85ZmyTeQWbKesy0kogveF0JOmK3HCU=;
        b=G0aFMwnXL3XlqQtltqTo0eoChMRvdBPFzMoicowzO+xAY5WA7wnecLBujcLmZah0k/
         e5mpG2PgiCXI5UV6aPxyJHgp+ak3mHqsIwGNyATLAY9IpyytJ/yv/eUNLEx8n5Z8IWxM
         5Ev81C4+GL/IiR5iIz/ra80OcP7ctuQ69Pj2L7/QrHYXrCEAAle4I31KIYWKOWdz7wXn
         M3HFOt505tL/bufF7RKhxyavqsmuktaYt6aLjMXM2bezAY35bwnHVGu6RsGL9aReXefA
         CUnwlpUOUePqMTfmrge6m16eiA1+eUvlxTaBEHUJphVGNMuBAicVc8kqC269vRlgE0G9
         pD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uR2yRSoFIyQFa85ZmyTeQWbKesy0kogveF0JOmK3HCU=;
        b=shtVrroqiuUYAyw+YFXCSsosJDJRILz5sz6vK1VsH+Iwz5Hpw+0QZZAfS2yTWdKAcI
         LsRI9vxrBao9if5yDgFpkxNS32sE7SqFKqpRxIlnwo6StnOXLiXICVmpb7zRcFWqYaIO
         bj/YOpkdalTB1WDJ8ElpCxIUaRktU8gIbfrmPDevuxmYwDpvty1WUslkCj1nhF46XaX2
         7/dNwQufB6st91nO8ZATukKw7Al/YIJJkAUXrnbYhB11DnB1iAws7kTjTqbFyoEw2ThV
         F+DiQp0UadDEXJAIV0jT/o1zPojU4yca1zFJq1iKAMNe6bImyUkRD3ftG6HIZExtWHWc
         frpQ==
X-Gm-Message-State: AOAM532zYYYyoNXg4qoypD4VUE1yfosvuTZ2mMAT36hITdGgFJgzV7aT
        JRf26giSuiprynKEXa4wqgxk/0ouODcSiDz02/jatg==
X-Google-Smtp-Source: ABdhPJyWM+KuxWSKm+WZakQM1coYpvqzhvFBssVoo8yKJsSvLXOonodEkq1Mrj4Ytt2McNT6VBun6xj6Gc9/hPkEfDk=
X-Received: by 2002:a2e:8816:: with SMTP id x22mr2543467ljh.377.1602907383409;
 Fri, 16 Oct 2020 21:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <788878CE-2578-4991-A5A6-669DCABAC2F2@amazon.com>
 <CAG48ez0EanBvDyfthe+hAP0OC8iGLNSq2e5wJVz-=ENNGF97_w@mail.gmail.com> <20201017033606.GA14014@1wt.eu>
In-Reply-To: <20201017033606.GA14014@1wt.eu>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 17 Oct 2020 06:02:36 +0200
Message-ID: <CAG48ez0x2S9XuCrANAQbXNi8Jjwm822-fnQSmr-Zr07JgrEs1g@mail.gmail.com>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Catangiu, Adrian Costin" <acatan@amazon.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jason Donenfeld <Jason@zx2c4.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "Graf (AWS), Alexander" <graf@amazon.de>,
        "MacCarthaigh, Colm" <colmmacc@amazon.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "bonzini@gnu.org" <bonzini@gnu.org>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "Weiss, Radu" <raduweis@amazon.com>,
        "oridgar@gmail.com" <oridgar@gmail.com>,
        "ghammer@redhat.com" <ghammer@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        KVM list <kvm@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Oct 17, 2020 at 5:36 AM Willy Tarreau <w@1wt.eu> wrote:
> On Sat, Oct 17, 2020 at 03:40:08AM +0200, Jann Horn wrote:
> > [adding some more people who are interested in RNG stuff: Andy, Jason,
> > Theodore, Willy Tarreau, Eric Biggers. also linux-api@, because this
> > concerns some pretty fundamental API stuff related to RNG usage]
> >
> > On Fri, Oct 16, 2020 at 4:33 PM Catangiu, Adrian Costin
> > <acatan@amazon.com> wrote:
> > > This patch is a driver which exposes the Virtual Machine Generation ID
> > > via a char-dev FS interface that provides ID update sync and async
> > > notification, retrieval and confirmation mechanisms:
> > >
> > > When the device is 'open()'ed a copy of the current vm UUID is
> > > associated with the file handle. 'read()' operations block until the
> > > associated UUID is no longer up to date - until HW vm gen id changes -
> > > at which point the new UUID is provided/returned. Nonblocking 'read()'
> > > uses EWOULDBLOCK to signal that there is no _new_ UUID available.
> > >
> > > 'poll()' is implemented to allow polling for UUID updates. Such
> > > updates result in 'EPOLLIN' events.
> > >
> > > Subsequent read()s following a UUID update no longer block, but return
> > > the updated UUID. The application needs to acknowledge the UUID update
> > > by confirming it through a 'write()'.
> > > Only on writing back to the driver the right/latest UUID, will the
> > > driver mark this "watcher" as up to date and remove EPOLLIN status.
> > >
> > > 'mmap()' support allows mapping a single read-only shared page which
> > > will always contain the latest UUID value at offset 0.
> >
> > It would be nicer if that page just contained an incrementing counter,
> > instead of a UUID. It's not like the application cares *what* the UUID
> > changed to, just that it *did* change and all RNGs state now needs to
> > be reseeded from the kernel, right? And an application can't reliably
> > read the entire UUID from the memory mapping anyway, because the VM
> > might be forked in the middle.
> >
> > So I think your kernel driver should detect UUID changes and then turn
> > those into a monotonically incrementing counter. (Probably 64 bits
> > wide?) (That's probably also a little bit faster than comparing an
> > entire UUID.)
>
> I agree with this. Further, I'm observing there is a very common
> confusion between "universally unique" and "random". Randoms are
> needed when seeking unpredictability. A random number generator
> *must* be able to return the same value multiple times in a row
> (though this is rare), otherwise it's not random.
[...]
> If the UUIDs used there are real UUIDs, it could be as simple as
> updating them according to their format, i.e. updating the timestamp,
> and if the timestamp is already the same, just increase the seq counter.
> Doing this doesn't require entropy, doesn't need to block and doesn't
> needlessly leak randoms that sometimes make people feel nervous.

Those UUIDs are supplied by existing hypervisor code; in that regard,
this is almost like a driver for a hardware device. It is written
against a fixed API provided by the underlying machine. Making sure
that the sequence of UUIDs, as seen from inside the machine, never
changes back to a previous one is the responsibility of the hypervisor
and out of scope for this driver.

Microsoft's spec document (which is a .docx file for reasons I don't
understand) actually promises us that it is a cryptographically random
128-bit integer value, which means that if you fork a VM 2^64 times,
the probability that any two of those VMs have the same counter is
2^-64. That should be good enough.

But in userspace, we just need a simple counter. There's no need for
us to worry about anything else, like timestamps or whatever. If we
repeatedly fork a paused VM, the forked VMs will see the same counter
value, but that's totally fine, because the only thing that matters to
userspace is that the counter changes when the VM is forked.

And actually, since the value is a cryptographically random 128-bit
value, I think that we should definitely use it to help reseed the
kernel's RNG, and keep it secret from userspace. That way, even if the
VM image is public, we can ensure that going forward, the kernel RNG
will return securely random data.
