Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B76E1A3A6B
	for <lists+linux-api@lfdr.de>; Thu,  9 Apr 2020 21:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgDITSE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Thu, 9 Apr 2020 15:18:04 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35246 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgDITSE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Apr 2020 15:18:04 -0400
Received: by mail-oi1-f195.google.com with SMTP id b10so453262oic.2;
        Thu, 09 Apr 2020 12:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QXRAlkJ3rCw/bTZOgIY7CDzFwnx0yQZmKTD1ENCI1IY=;
        b=FvT5SMe/hsClg5o4ADDGtCUC6bn/z7iu20pvFBtjTGQH9Ne+fgXU0KGY5WDCWndRC3
         D7iY/YT42zFKWFQNcJFg11rdQejgTMxOiz4qz8vlBPF7yMLbILrcA1hgslObh5jCUNcC
         B+VNgVqyqOKAQh7mhMF0glpTSHAFUTlCaKqs9VK+t4+fB0/p09JHynBtIylMXQpK206E
         SMZ4AyOSSRWuNnHt5GzeDOtjbvnRxLV9hfLz4AvQAByq2jPiVFCx3BA/QgyP75ErWK43
         mKcJ545rxImxEkD5QwN3sTHefCZ1y96WTIg9dmC0Hch8iVWUdTRiibzob3yLC0WgGyvh
         Skrw==
X-Gm-Message-State: AGi0PuZihme8+y6H5heoSxCdM1jtr6PFsO9GEoZoZxsrt5NQAK+v4Ek4
        Gnn9SYoD0S2B3J1jfQsFhIsr9Lai7Q4fvEOOgik=
X-Google-Smtp-Source: APiQypIN28QpzFRXKr8LxKyIJkWbtETYUjlzokfO48YRixxeBZfG2QhrPvDMMZJSsy7IbQZs6/TBPZzLKO13p2u/NbE=
X-Received: by 2002:aca:da8b:: with SMTP id r133mr725258oig.81.1586459883987;
 Thu, 09 Apr 2020 12:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <703440af-031c-16b5-c1ff-54fb4bb5e10c@gmail.com>
In-Reply-To: <703440af-031c-16b5-c1ff-54fb4bb5e10c@gmail.com>
From:   Andrey Vagin <avagin@openvz.org>
Date:   Thu, 9 Apr 2020 12:17:52 -0700
Message-ID: <CANaxB-y0ZB223dQgvxvUHRzkn4f-_B2vTzYxe_mi=o+3SJ4yVw@mail.gmail.com>
Subject: Re: A further though on /proc/PID/timens_offsets
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Dmitry Safonov <dima@arista.com>,
        Linux API <linux-api@vger.kernel.org>,
        Containers <containers@lists.linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Adrian Reber <adrian@lisas.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Apr 7, 2020 at 6:24 AM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:

>        The  clock-id  identifies the clock whose offsets are being shown.
>        This field is either 1, for CLOCK_MONOTONIC, or 7, for CLOCK_BOOT‐
>        TIME.
>
> What was the reason for exposing numeric clock IDs in the
> timens_offsets file? In API terms, that seems a little ugly.
>
> I think it would have been much nicer if the clocks were defined
> symbolically in this file. I.e., that reading the file would have
> shown something like
>
> monotonic    x    y
> boottime     x    y
>
> And that records similarly with symbolic clock names could have
> been written to the file. Was there a reason not to do this?

No, there was not except that I haven't thought about this. I agree
that symbolic clock names looks nicer for humans, but numeric clock
IDs are a bit more convenient when we  need to set/read offsets from
code. This interface is in the released kernel, so I think we can't
change the format of the content of this file. But we can add support
of symbolic clock names for setting clock offsets. What do you think?

Thanks,
Andrei
