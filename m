Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4D21DBA4B
	for <lists+linux-api@lfdr.de>; Fri, 18 Oct 2019 01:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441820AbfJQXrx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 17 Oct 2019 19:47:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35054 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441818AbfJQXrx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 17 Oct 2019 19:47:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id 205so2650246pfw.2;
        Thu, 17 Oct 2019 16:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7mNsONhNkHkS51dautMbOQ4W+l8wA8470+lyf5fBUAg=;
        b=Z/M9G1fvbwEa9vfs4Pij8IMfXklioaVs/lSyODsaMcWvj55ZQe9uxSZKsw13SU8PUY
         cyMDyR+cctVfhtcA5lFY8Heiz7hnTbRyEmhZ0XlqZfbIh2fIOJFj/I1VwRZmpxkOp9Fz
         u9mxGuolhCFqhbESZvO4fX8/kwFgYu1etwlSYH/4hQywezF7RI1AwqYcoQi5gO5YIUgo
         sUhFTQEvwbWegqc5opPpxQtpYBSH+u60kKpri2rVG+8mU7auw5cEBzSXKs7/GwZFcww4
         BUrnQc5ujJmJ20jn24aYazylFuXhaCzS3JR5TrQbsbix/XJtNCQpjkzg5xSwC67bsBng
         6LRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7mNsONhNkHkS51dautMbOQ4W+l8wA8470+lyf5fBUAg=;
        b=UTtfBItK+XY6ReTfQVa9r8h2Eo1SC17FZE4Gq8eSA89b1U53vshZxI1Oh4IPnGgsJs
         FyKTPFnzPrzsGmX3h2lLKttZgEh7CD3LwRg/5SUVNBm/zPfTtqw5Xk1L/EtHkGBUSLH8
         iMTIUVjFFQp7O5TTeTVB6ZRSdvZiyEJGuxM/PmYgKwYL6xRfL+QXEqkQWwNTMrs5wh9B
         afqWe8oxhGj0tmI4yGbXa0c7Ssgvtd7ks+Z+92Zdt7NkvGcrYtp/ZghDbwRJmiBtApLl
         CT1/t1MvWH6fpEWWKvIDthzCJjsbEekWuxaL3AVSOs8iA0+Q7YYoZYEC9uI6LryeuG+g
         ZagQ==
X-Gm-Message-State: APjAAAWiLDShnOAasanuOtKtpOCoDIQfq1eo0S7EIJ7HwzzdTEH1ZRbq
        Oo4XxJlForu566kk65fOJ34=
X-Google-Smtp-Source: APXvYqzIh7d8nuP1RIXa8GAwaElvhG+RytvLlsiq9StzCHLSuvg3y2V16dnUVP4re0ZLEoNy3JJGFQ==
X-Received: by 2002:a17:90a:8c14:: with SMTP id a20mr7442781pjo.77.1571356071565;
        Thu, 17 Oct 2019 16:47:51 -0700 (PDT)
Received: from gmail.com ([2620:0:1008:fd00:25a6:3140:768c:a64d])
        by smtp.gmail.com with ESMTPSA id j26sm3712353pgl.38.2019.10.17.16.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 16:47:50 -0700 (PDT)
Date:   Thu, 17 Oct 2019 16:47:48 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCHv7 00/33] kernel: Introduce Time Namespace
Message-ID: <20191017234748.GA26011@gmail.com>
References: <20191011012341.846266-1-dima@arista.com>
 <alpine.DEB.2.21.1910171122030.1824@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910171122030.1824@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Oct 17, 2019 at 11:24:45AM +0200, Thomas Gleixner wrote:
> On Fri, 11 Oct 2019, Dmitry Safonov wrote:
> > We wrote two small benchmarks. The first one gettime_perf.c calls
> > clock_gettime() in a loop for 3 seconds. It shows us performance with
> > a hot CPU cache (more clock_gettime() cycles - the better):
> > 
> >         | before    | CONFIG_TIME_NS=n | host      | inside timens
> > --------------------------------------------------------------
> >         | 153242367 | 153567617        | 150933203 | 139310914
> >         | 153324800 | 153115132        | 150919828 | 139299761
> >         | 153125401 | 153686868        | 150930471 | 139273917
> >         | 153399355 | 153694866        | 151083410 | 139286081
> >         | 153489417 | 153739716        | 150997262 | 139146403
> >         | 153494270 | 153724332        | 150035651 | 138835612
> > -----------------------------------------------------------
> > avg     | 153345935 | 153588088        | 150816637 | 139192114
> > diff %  | 100       | 100.1            | 98.3      | 90.7
> 
> 
> That host 98.3% number is weird and does not match the tests I did with the
> fallback code I provided you. On my limited testing that fallback hidden in
> the slowpath did not show any difference to the TIME_NS=n case when not
> inside a time namespace.

You did your experiments without a small optimization that we introduced
in the 18-th patch:

[PATCHv7 18/33] lib/vdso: Add unlikely() hint into vdso_read_begin()

When I did my measurements in the first time, I found that with this
timens change clock_gettime() shows a better performance when
CONFIG_TIME_NS isn't set. This looked weird for me, because I don't
expect to see this improvement. After analyzing a disassembled code of
vdso.so, I found that we can add the unlikely() hint into
vdso_read_begin() and this gives us 2% improvement of clock_gettime
performance on the upsteam kernel.

In my table, the "before" column is actually for the upstream kernel
with the 18-th patch. Here is the table with the real "before" column:

        | before    | with 18/33 | CONFIG_TIME_NS=n | host      | inside timens
------------------------------------------------------------------------------
avg     | 150331408 | 153345935  | 153588088        | 150816637 | 139192114
------------------------------------------------------------------------------
diff %  |       98  |      100   | 100.1            | 98.3      | 90.7
------------------------------------------------------------------------------
stdev % |       0.3 |     0.09   | 0.15             | 0.25      | 0.13

If we compare numbers in "before", "host" and "inside timens" columns, we
see the same results that you had. clock_gettime() works with the
same performance in the host namespace and 7% slower in a time
namespace.

Now let's look why we have these 2% degradation in the host time
namespace. For that, we cat look at disassembled code of do_hres:

Before:
   0:   55                      push   %rbp
   1:   48 63 f6                movslq %esi,%rsi
   4:   49 89 d1                mov    %rdx,%r9
   7:   49 89 c8                mov    %rcx,%r8
   a:   48 c1 e6 04             shl    $0x4,%rsi
   e:   48 01 fe                add    %rdi,%rsi
  11:   48 89 e5                mov    %rsp,%rbp
  14:   41 54                   push   %r12
  16:   53                      push   %rbx
  17:   44 8b 17                mov    (%rdi),%r10d
  1a:   41 f6 c2 01             test   $0x1,%r10b
  1e:   0f 85 fb 00 00 00       jne    11f <do_hres.isra.0+0x11f>
  24:   8b 47 04                mov    0x4(%rdi),%eax
  27:   83 f8 01                cmp    $0x1,%eax
  2a:   74 0f                   je     3b <do_hres.isra.0+0x3b>
  2c:   83 f8 02                cmp    $0x2,%eax
  2f:   74 72                   je     a3 <do_hres.isra.0+0xa3>
  31:   5b                      pop    %rbx
  32:   b8 ff ff ff ff          mov    $0xffffffff,%eax
  37:   41 5c                   pop    %r12
  39:   5d                      pop    %rbp
  3a:   c3                      retq
...

After:
   0:   55                      push   %rbp
   1:   4c 63 ce                movslq %esi,%r9
   4:   49 89 d0                mov    %rdx,%r8
   7:   49 c1 e1 04             shl    $0x4,%r9
   b:   49 01 f9                add    %rdi,%r9
   e:   48 89 e5                mov    %rsp,%rbp
  11:   41 56                   push   %r14
  13:   41 55                   push   %r13
  15:   41 54                   push   %r12
  17:   53                      push   %rbx
  18:   44 8b 17                mov    (%rdi),%r10d
  1b:   44 89 d0                mov    %r10d,%eax
  1e:   f7 d0                   not    %eax
  20:   83 e0 01                and    $0x1,%eax
  23:   89 c3                   mov    %eax,%ebx
  25:   0f 84 03 01 00 00       je     12e <do_hres+0x12e>
  2b:   8b 47 04                mov    0x4(%rdi),%eax
  2e:   83 f8 01                cmp    $0x1,%eax
  31:   74 13                   je     46 <do_hres+0x46>
  33:   83 f8 02                cmp    $0x2,%eax
  36:   74 7b                   je     b3 <do_hres+0xb3>
  38:   b8 ff ff ff ff          mov    $0xffffffff,%eax
  3d:   5b                      pop    %rbx
  3e:   41 5c                   pop    %r12
  40:   41 5d                   pop    %r13
  42:   41 5e                   pop    %r14
  44:   5d                      pop    %rbp
  45:   c3                      retq
...

So I think we see these 2% degradation in the host time namespace,
because we need to save to extra registers on stack. If we want to avoid
this degradation, we can mark do_hres_timens as noinline. In this case,
the disassembled code will be the same as before these changes:

  0000000000000160 <do_hres>:
  do_hres():
   160:   55                      push   %rbp
   161:   4c 63 ce                movslq %esi,%r9
   164:   49 89 d0                mov    %rdx,%r8
   167:   49 c1 e1 04             shl    $0x4,%r9
   16b:   49 01 f9                add    %rdi,%r9
   16e:   48 89 e5                mov    %rsp,%rbp
   171:   41 54                   push   %r12
   173:   53                      push   %rbx
   174:   44 8b 17                mov    (%rdi),%r10d
   177:   41 f6 c2 01             test   $0x1,%r10b
   17b:   0f 85 fc 00 00 00       jne    27d <do_hres+0x11d>
   181:   8b 47 04                mov    0x4(%rdi),%eax
   184:   83 f8 01                cmp    $0x1,%eax
   187:   74 0f                   je     198 <do_hres+0x38>
   189:   83 f8 02                cmp    $0x2,%eax
   18c:   74 73                   je     201 <do_hres+0xa1>
   18e:   5b                      pop    %rbx
   18f:   b8 ff ff ff ff          mov    $0xffffffff,%eax
   194:   41 5c                   pop    %r12
   196:   5d                      pop    %rbp
   197:   c3                      retq
...

But this change will affect the performance of clock_gettime in a time
namespace.

My experiments shows that with the noinline annotation for
do_hres_timens, clock_gettime will work with the same performance in the
host time namespace, but it will be slower on 11% in a time namespace.

Thomas, what do you think about this? Do we need to mark do_hres_timens
as noinline?

Thanks,
Andrei
