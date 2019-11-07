Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 267E5F3683
	for <lists+linux-api@lfdr.de>; Thu,  7 Nov 2019 19:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725294AbfKGSC1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 7 Nov 2019 13:02:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54998 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfKGSC1 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 7 Nov 2019 13:02:27 -0500
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1AC9359445
        for <linux-api@vger.kernel.org>; Thu,  7 Nov 2019 18:02:27 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id m189so3124789qkc.7
        for <linux-api@vger.kernel.org>; Thu, 07 Nov 2019 10:02:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QxggtM34dsozsdPFHx2LTGAue0f3iHAFGKQCXNuEsHo=;
        b=dXbvw4+DCQ0ioJjzh+t2uvjSEbxTlbFAVFDYmjRs1v95hGmtSCvjF8yXy4Io+flC5B
         V/SN8frIGRxAksr2txE0Yy86JRzixA2g5NM5UZz5Z6G9ywHSl8O5WGnnOR4uEx4e+I/t
         RE7Z28XpQ3TuCvxU18FvW10TSnyrNJNKumbUMwKGaP7U2yUao3S8HsLOzHtvkL9EXwCT
         CpKQy0dRLc/i2uU+pnVpsaq7Y4oyeHZAtIJQIY7tGOE1IN5K6FK8EfR8gsvBJGz3h7g6
         SSGSY+Ug0i0udArgEy9ZDiiIQKfLQcGqsvax5R107lQ5qtkxeDTfOb+gQe1zQsiZCFev
         QLDQ==
X-Gm-Message-State: APjAAAWpvvZkym0S5ryewJApTTi4ow8gVuiogEC+/sqtYRtbZlDNG6Zf
        PtLDQ+sxcui6RLf5DUToH5MGRytv//aXS2+EUyCWwHmhaV9htDaD3vcITOyCFa+0QcnzwQjAKoi
        cWf6fpWAmMziMtcnUhSal
X-Received: by 2002:a37:9d0:: with SMTP id 199mr4189156qkj.356.1573149746289;
        Thu, 07 Nov 2019 10:02:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqyCNPN4b9PA1fPHJ1VCAr9WbVHz3ruEVNB2wC6T5dRsc2gQnB/emFGqxY6MXY7u4Zc+rXyByQ==
X-Received: by 2002:a37:9d0:: with SMTP id 199mr4189120qkj.356.1573149745896;
        Thu, 07 Nov 2019 10:02:25 -0800 (PST)
Received: from [192.168.1.4] (135-23-175-75.cpe.pppoe.ca. [135.23.175.75])
        by smtp.gmail.com with ESMTPSA id v54sm1538877qtc.77.2019.11.07.10.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2019 10:02:25 -0800 (PST)
Subject: Re: Continuing the UAPI split
To:     Florian Weimer <fweimer@redhat.com>,
        Elichai Turkel <elichai.turkel@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-api@vger.kernel.org, libc-alpha <libc-alpha@sourceware.org>
References: <CALN7hCK0EXLXjPRPr+tuuF2-uQvkLMCFDNzGhv9HS-jrAz6Hmg@mail.gmail.com>
 <0B17C6F2-DC2B-4192-B4AD-BD11D6B9F2B6@ubuntu.com>
 <87zhh7j38y.fsf@oldenburg2.str.redhat.com>
 <CALN7hCJ_umFqC1L0T19CuiGiGoVwac5807NDw4LiDqSD-VJL=Q@mail.gmail.com>
 <87zhh7hlbl.fsf@oldenburg2.str.redhat.com>
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
Message-ID: <bc1d29f7-0990-b52f-7a5b-f4faf722fe16@redhat.com>
Date:   Thu, 7 Nov 2019 13:02:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87zhh7hlbl.fsf@oldenburg2.str.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 11/7/19 8:23 AM, Florian Weimer wrote:
> Officially, it's supposed to work today.  We have one glibc developer
> who says that it's easy to solve, but I disagree strongly.  The fact
> that the problems are not fixed promptly suggests that it's anything but
> simple.

Is that one glibc developer me? :-)

They aren't easy to solve, but there is a magic process in place.

Getting the definitions to line up is part of the work involved.

Sometimes they may not line up, in that case it doesn't work.

> What I've been doing instead is to include UAPI headers directly from
> glibc headers if it's technically feasible.  (It's not possible in POSIX
> mode, where we have to manage the set of exported symbols closely, or
> generally with old compilers which do not have __has_include.)  See
> <bits/statx.h>, <bits/statx-generic.h> etc. in current glibc for an
> example.

That's really the best way to solve it if you can.

> If you add more type definitions to kernel headers, this might interfere
> with such usage of UAPI headers because today, we need to provide our
> own definitions for many things not in UAPI headers, and the currently
> deployed glibc headers are simply not compatible with such future
> changes.

Right.

-- 
Cheers,
Carlos.
