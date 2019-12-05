Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5FB0114570
	for <lists+linux-api@lfdr.de>; Thu,  5 Dec 2019 18:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbfLERNE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Dec 2019 12:13:04 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39349 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729396AbfLERND (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Dec 2019 12:13:03 -0500
Received: by mail-lj1-f193.google.com with SMTP id e10so4453688ljj.6
        for <linux-api@vger.kernel.org>; Thu, 05 Dec 2019 09:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zYNLY1IlQbFxutIFweWCQvjwN9b0IsGYV2okK9HrfFg=;
        b=Q0FUaDCgejnj2j913m9DkZ5BcPyxfvWCsvBxLXqstFY2bocRU9mYGGdVT6TyixAaF9
         S2hdwaxlIrLjm/VudylZUBLif/OSS4AVyaDGMpzqZdSB/9DnkfX4SEUoI9oj/pbE/ewR
         2kNMP8DNxG23lhz/9/1l0TfZQjJpzTexlyrHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zYNLY1IlQbFxutIFweWCQvjwN9b0IsGYV2okK9HrfFg=;
        b=dvcOrrSmnMtR7M7hiICXffROwo1l6IKnn9onmJEsciGyXA0LaRIT+jVZUveJLUH1qP
         ZSE3QAMPUCQ+UqJsh74UwsZcBWk/4JsRTCSLJr49cZh571CDbQ3rp23+pLdd3tCj55PZ
         XSt90ukX8wZRKvswDZJ6R1wfjOowX9aHTCVyRme92RaAs2J59dGbwxN9oF6L/+nZuaDj
         QRL7zv0D1BVhCY0qwVhbDPQPSfxG5QnvqbeDuazF/0OC1aiGAHONE7CLeBOe2SPtgWa0
         oHZNZ9arXV60O0ZA5RRutN54Z3wMFRcSQBfWIkdsIzbfF/SVhPVsEdKrK495ycJoArEr
         AI9w==
X-Gm-Message-State: APjAAAWy3/ttqH6b7SMffTB/nPB7PWUoj6sryqL+r5c5IAGYjpPWPO9v
        e0IVdJf48rzvKmTxhS8BS/MYQAzuI1c=
X-Google-Smtp-Source: APXvYqymA2nWqCmC6mlj6smjzR4Oum71mhYv5uQCck2EbxuUufXSasvJTw1J7tTv+WYDB3+AGpZqHw==
X-Received: by 2002:a2e:b5b8:: with SMTP id f24mr6061449ljn.188.1575565980796;
        Thu, 05 Dec 2019 09:13:00 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 144sm5391656lfi.67.2019.12.05.09.12.59
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 09:12:59 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 203so3035053lfa.12
        for <linux-api@vger.kernel.org>; Thu, 05 Dec 2019 09:12:59 -0800 (PST)
X-Received: by 2002:a19:4351:: with SMTP id m17mr6095833lfj.61.1575565978909;
 Thu, 05 Dec 2019 09:12:58 -0800 (PST)
MIME-Version: 1.0
References: <31452.1574721589@warthog.procyon.org.uk> <20191205125826.GK2734@twin.jikos.cz>
 <1593.1575554217@warthog.procyon.org.uk>
In-Reply-To: <1593.1575554217@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Dec 2019 09:12:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgwwJ+ZEtycujFdNmpS8TjwCYyT+oHfV7d-GekyaX91xg@mail.gmail.com>
Message-ID: <CAHk-=wgwwJ+ZEtycujFdNmpS8TjwCYyT+oHfV7d-GekyaX91xg@mail.gmail.com>
Subject: Re: [GIT PULL] pipe: Notification queue preparation
To:     David Howells <dhowells@redhat.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Dec 5, 2019 at 5:57 AM David Howells <dhowells@redhat.com> wrote:
>
> David Sterba <dsterba@suse.cz> wrote:
>
> > [<0>] pipe_write+0x1be/0x4b0
>
> Can you get me a line number of that?  Assuming you've built with -g, load
> vmlinux into gdb and do "i li pipe_write+0x1be".

If the kernel is built with debug info (which you need for the gdb
command anyway), it's much better to just use

   ./scripts/decode_stacktrace.sh

which gives all the information for the whole backtrace.

It would be interesting to hear if somebody else is waiting on the
read side too.

             Linus
