Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9B3FC900
	for <lists+linux-api@lfdr.de>; Thu, 14 Nov 2019 15:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfKNOfz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 14 Nov 2019 09:35:55 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:51003 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfKNOfz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 14 Nov 2019 09:35:55 -0500
Received: from mail-qv1-f47.google.com ([209.85.219.47]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MUooJ-1iM5H61Mw5-00QnXD; Thu, 14 Nov 2019 15:35:53 +0100
Received: by mail-qv1-f47.google.com with SMTP id i3so2409652qvv.7;
        Thu, 14 Nov 2019 06:35:53 -0800 (PST)
X-Gm-Message-State: APjAAAX+3GU8M9fqYdTDoiy79ddpna94vkO4v+4uwR8vRos/yu7VMVRi
        1xejSJoknQpHSEb+vHMrxZUzMQXEIy70XQVUGOU=
X-Google-Smtp-Source: APXvYqycNsPx974oI5YnaYtZwuZKkGQIcudx7wCYaSZtCzlgdkMx+dpzCYGjmVzMcpznA11PUC6kjihXkR3/n0CKU+Y=
X-Received: by 2002:a0c:a9cc:: with SMTP id c12mr8417384qvb.222.1573742152140;
 Thu, 14 Nov 2019 06:35:52 -0800 (PST)
MIME-Version: 1.0
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108211323.1806194-8-arnd@arndb.de>
 <alpine.DEB.2.21.1911132250010.2507@nanos.tec.linutronix.de>
 <CAK8P3a2bxDZVKgcJoa99wr3tDyYckQAdk2f=RnL4vTFPjm3tXQ@mail.gmail.com> <alpine.DEB.2.21.1911141457120.2507@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1911141457120.2507@nanos.tec.linutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Nov 2019 15:35:35 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0qm1FW+mqcMvzyb8WVvqtF-POMpir+WVezEObaYLCCRg@mail.gmail.com>
Message-ID: <CAK8P3a0qm1FW+mqcMvzyb8WVvqtF-POMpir+WVezEObaYLCCRg@mail.gmail.com>
Subject: Re: [PATCH 17/23] y2038: time: avoid timespec usage in settimeofday()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>,
        Corey Minyard <cminyard@mvista.com>,
        zhengbin <zhengbin13@huawei.com>,
        Li RongQing <lirongqing@baidu.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:vTkO2UihZATd4ascmfM7HonFINA46Gzd02p6oqajIizANs0ziaL
 KtqO4Tr5vyNzSsO1CL/z8dQ1ub0D/ueSJN/XEBD9OEyoW6UdcVp1TOwWVAfSZMHULDvJ4y2
 t5wXcHsW3YfPES8YAdelta7112ZaW3sP5sSdKAtV49CpJIwhlbYWBsRkZ1uWJO6JTuxvBqE
 ZIjezZoOMguSfJcCzF8bw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XTYDQS696YA=:gcAS4B6hlhDgUrklpBe86A
 D3lF/rocGAFmA4bDcRbxZx0u9hJ2osrQFbt1xvySBTcDYBzwR33KyVugER2DQs6WzvlI+6OER
 9lF0x+Vxx7whyxhie5ia/abKfzK5ZUMrwiiaFYQX8dp85q/Axxkylku7L+UuWxwvjbQStV+n1
 VTaEUZe5tBPFHv3h/vKDMGzaIrnW5c4L/YT+XN1Qr59r66iTr/H+PURV6ANzCYm8JSmEotAXF
 EBhqNtDZDhdXVRWe40XtmgsE+36O3ao9Z4FDGv2v5wOAkJ128eb4zJXVD8Tn7pLicjc2SqINH
 Fyobq/djuaeKbxqOqTaVLY2mMDyIXHZ8c4tykmmhjfJyeHneqE4vNSE5/TZl+pbZ0P6FNpTqt
 VQVJ0TccDgH3TsQCa7nArwqpJqEvBullHlooj6dX9LUGgSA1gB4ioS69BOAcmdwwAtf5BeLDe
 RCSRqFDITAit1AwZ54fAp1g9kZRD25yVe0Sak4JJ/yTR4qpi7uHkfIMUo4glStQI1wPXdzxcb
 goDWOEfu9zAaufZMMS6boTjYE2HdXSWcaUA/k9F/JUU9HepYWCF1y4/1OHuTBfCsO02iHuKO7
 wxodFE4Z5Ktt/xS7brl0gIzXcp6IKEkRUtKWZxGSH+4Tscv6vhKuYYZDcGGMg+QjwAPQpMlpB
 5SEVfvXqXJ027xJXW3LMBv20hWpr3ZJqrSbPZnnupn5nYPPI05n9mbUcnIwBm9aPzEaZXlTfc
 ok6cBVgzfiLRHL8e1vPwvSFkkZogMi7JcSCat74dBcBAz7B5BRy9lALZ1AOcT8yudT54bOn71
 L19dPz2qY0WSN9oYE1kG0ARcAtBSvTHG7STEbv4iLZPIOo3WYY1dl5cMsKtpeZei6EqImz1ft
 9PCTjFdZRm9uByH2p2TA==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Nov 14, 2019 at 3:04 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 14 Nov 2019, Arnd Bergmann wrote:
> > On Wed, Nov 13, 2019 at 10:53 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > My idea was to not duplicate the range check that is done
> > in do_sys_settimeofday64() and again in do_settimeofday64:
> >
> >         if (!timespec64_valid_settod(ts))
> >                 return -EINVAL;
> >
> > The only check we should need in addition to this is to ensure
> > that passing an invalid tv_usec number doesn't become an
> > unexpectedly valid tv_nsec after the multiplication.
>
> Right, but please add a proper comment as you/we are going to scratch heads
> 4 weeks from now when staring at that check and wondering why it is
> incomplete.

Ok, done. I had just uploaded the branch with the fixup for
the __user pointer access in the same patch, but that version
had introduced another typo. I hope the version I uploaded
now has all known issues addressed for tomorrow's linux-next.

      Arnd
