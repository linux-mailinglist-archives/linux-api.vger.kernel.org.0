Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D501F40CCC9
	for <lists+linux-api@lfdr.de>; Wed, 15 Sep 2021 20:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhIOSt3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Sep 2021 14:49:29 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:35103 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbhIOSt2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Sep 2021 14:49:28 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mwfeu-1moPAT3bkw-00y89t; Wed, 15 Sep 2021 20:48:07 +0200
Received: by mail-wr1-f48.google.com with SMTP id g16so5443007wrb.3;
        Wed, 15 Sep 2021 11:48:07 -0700 (PDT)
X-Gm-Message-State: AOAM531f+v44h4fcdFn2JsdlESZ7wPV0D+sjQB2jGS/Db/5yxob+tHU0
        DpeOsOWs67TQKIytAAqrsB9as/+CF6Jy81FqWcw=
X-Google-Smtp-Source: ABdhPJxK7SeTGX8+XfGCJ4SbF2UTweNhxicgClsiVZ2HPcmo85hjrsvQk6FDN6pdsJWlaTcZb9qud2EO6qBml0363OE=
X-Received: by 2002:adf:f884:: with SMTP id u4mr1571436wrp.411.1631731687472;
 Wed, 15 Sep 2021 11:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210915140710.596174479@infradead.org> <20210915141525.621568509@infradead.org>
 <YUITUXbnzAK98DEl@hirez.programming.kicks-ass.net>
In-Reply-To: <YUITUXbnzAK98DEl@hirez.programming.kicks-ass.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Sep 2021 20:47:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1s=fJPyaCUj0otNA2bWjY09F_ir2zxigFgaZ69ejHkcw@mail.gmail.com>
Message-ID: <CAK8P3a1s=fJPyaCUj0otNA2bWjY09F_ir2zxigFgaZ69ejHkcw@mail.gmail.com>
Subject: Re: [PATCH 16/20] futex: Implement sys_futex_waitv()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora kernel ML <kernel@collabora.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Linux API <linux-api@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:9B4JQw9ex8Xn/WXdpP7jH8OJB0y+5WRYBwQgt/Yzthxvw/sjEd9
 LY2u9g7LfxU2FyUSWQr4PJJIqXCP4AlXVNYaonPwHow74liegzd12IT3hNJ8ayJuZ8qndiH
 CABnych4/cH3KD67c1BPJEtkqRzV+ZGPWraJtiYntRo3ONtSD/xcKMuNr/+GtoyyJg1wvm9
 bL8Up9spm3OA+sq5Ortyw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qRBr4pAJpNg=:3eI9IEcTuXlQ8DyQBVf49D
 /wMI8584iVETQUlxgdEST50UnsSDGY862QhU47nc6/T96RIcBBTxGq38kdQtHOFCbmW+mOtO2
 viYXqzIHGgCVWEqPA+eezDuD3yBYU+rHSCkKreCqbnff//w902GgRM+RGPoLlFYENrqzUA0A1
 MJOZRbXqAlS1zIdPu/wN4D7+tpZLiSj5lbrXUhNItmT/5OEGHZ+NCq4YaM3cq+xHYhmmrnvdj
 1BWABAYm+8kRMhkAJPwFys9uByvZzQvmLRAKD1dbMtfqVzSzUuyeJr+/iT39ogNGlzPZJCiDB
 RfSYb6IZ+pntqvnJsHyxCGlF8HJTdm97MGT7BsWFFClXWHG1t+TvTxA3tQoc0cBIh0BBV/cDD
 eVAGNHlsGfF6QG3e3Ye7283ftH75+fuoZxAx280ER6phqz5Ri2D6483TOvov03930Vogc/K1+
 xgGmOS5PFRBxdRvpKr7c01ZzxPKAh96LICFveMmW0jDaqkqeMXRjeJLIh5fftxzNzmtAJ1Yv6
 ZEquO9l/tTabGzsF1XcV2VHuwiA4SrV8Ne6qjC1Q061+RSAdgvwAbZrGL1z+ub+n0KGXeXPJH
 XRtN3lsHoJvwYrUEDut5JpnwB6wQMTSxU6WVbOOaLCXyw2IBXAg52fJsRsTzKNV+73V/Cyfxf
 5nAXGKC15d2yivysnDigGn9vf+0N5g1GZHK7tPynBVO4T2I7BlXG3d2HkoRXghy0C81YCsKN2
 1espmMcRfoiHA1Noou8Iod9p2qqOugNbfIkw+Q==
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 15, 2021 at 5:39 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Sep 15, 2021 at 04:07:26PM +0200, Peter Zijlstra wrote:
> > +SYSCALL_DEFINE4(futex_waitv, struct futex_waitv __user *, waiters,
> > +             unsigned int, nr_futexes, unsigned int, flags,
> > +             struct __kernel_timespec __user *, timo)
>
> So I utterly detest timespec.. it makes no sense what so ever.
>
> Can't we just, for new syscalls, simply use a s64 nsec argument and call
> it a day?
>
> Thomas, Arnd ?

Do you mean passing the nanoseconds by value instead of a pointer?
I think that would be worse, since that means having incompatible calling
conventions between 32-bit and 64-bit architectures, and even
between 32-bit architectures that have different requirements for 64-bit
function arguments.

If we pass it by reference, there is much less to gain from changing the
timespec to plain nanoseconds. I wouldn't object to that, but I don't
see it helping much either. It would work for relative timeouts, but the
general trend seems to be to specify timeouts as absolute times,
and that would force each caller to read the time using clock_gettime()
and then convert it to nanoseconds before adding the timeout.

Specifying the timeout in terms of 32-bit relative milliseconds would the
way that epoll() does would be really simple, but that still feels odd.

        Arnd
