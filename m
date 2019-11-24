Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1AA1081A4
	for <lists+linux-api@lfdr.de>; Sun, 24 Nov 2019 05:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfKXEvg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 23 Nov 2019 23:51:36 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33820 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfKXEvg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 23 Nov 2019 23:51:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so13415832wrr.1;
        Sat, 23 Nov 2019 20:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UMNvMZ2fiueHFeBLtH1yqoxzy6gBcmr82O5GZYCic0I=;
        b=cqqaBO8rwLZCQAQHTXvCo2RUBKkg8tdFoISyP22RXsT8TTixtNpakZvXcy6Yd/mQIX
         sSt4Wd4DXjh34IK6EX00eNiCIJhjF4YyFXVyOMgNzWIRzt4rIUqz0ibinZKsOOU2Bd+k
         MqZ8DJcC7B2lXlns95IdHGkfWSuBxOzflkmFJziQvDK0lwAHvJmnWrp1lLnFzogIQmUf
         P83uCcRySIPT4G9dAx3Xs9RzwvIUC/QOfgczueCPmJmjkMTTOMaXckNXxRjF+Gp2tVjh
         fNPFNNp+vUugcdWyBf/a9ZZur8HzS5F44nlHVKsxTq+lo+gLLQr3EkumPuLgTtt2JTmv
         ffKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UMNvMZ2fiueHFeBLtH1yqoxzy6gBcmr82O5GZYCic0I=;
        b=m8w8bieCVaPa2snwVztCmToLo9S7mK3mCXywWBtlpIU//INUSVcawK/Scp3G+fzQOJ
         MDB9Z2rzHTxz2qRMtakzDC0SF/nMnYmlbNVxNXj2H+ZVMVx/jckhIbIG4FeS63yUP3Ty
         aOcbSEeilsuYcZeMBordWb4HrveBaoRt5xDhPi+aWUaiOBObM+eifYbHSQRjfozuAE3d
         86gTm1q9GaD/QnWnxwKx2Wo8Jn5YWCLq6GaPld1xCa4R5AAs9yyDAMDNm6H++VC4mLh1
         nJ4Jdeth6iNHGhWc0CnnkhetBVJ7S6vYA+v47YLP+7ELJIVIY/5zTlxojc3PFtJtwz4z
         cWLw==
X-Gm-Message-State: APjAAAWZ7CCbdmvcYnpR0kAZ2gXa1R9FmuEVnOaLmxN9RavepJDGfBar
        sWXE7LjHXhlVfErlykRM9Vl950KnFOfN1acVuBQ=
X-Google-Smtp-Source: APXvYqzbmBMaUZ7OFJ0tend1/u7Cs6qVFDD/rGCvqIMqwRuT0rDHfIou/pqOPQldrOCGd5rCi9+hdcY/eGpacKVnWhE=
X-Received: by 2002:adf:ea8d:: with SMTP id s13mr24873434wrm.366.1574571093582;
 Sat, 23 Nov 2019 20:51:33 -0800 (PST)
MIME-Version: 1.0
References: <6157374.ptSnyUpaCn@positron.chronox.de> <2369119.jSEA3qhmGI@positron.chronox.de>
In-Reply-To: <2369119.jSEA3qhmGI@positron.chronox.de>
From:   Sandy Harris <sandyinchina@gmail.com>
Date:   Sun, 24 Nov 2019 12:51:19 +0800
Message-ID: <CACXcFmkBQAZd4bSfQvqeCsoTjMr0-uSjKciD6y9EkMN3c9ppJw@mail.gmail.com>
Subject: Re: [PATCH v24 01/12] Linux Random Number Generator
To:     =?UTF-8?Q?Stephan_M=C3=BCller?= <smueller@chronox.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Nicolai Stange <nstange@suse.de>,
        "Peter, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Stephan M=C3=BCller <smueller@chronox.de> wrote:

> In an effort to provide a flexible implementation for a random number
> generator that also ...

As usual, some of your proposals make considerable sense to me &
others do not, at least on first reading. I may have more comments
after reflecting some.

Meanwhile, a couple of things jump out at me:

>  (a) When an interrupt occurs, the high-resolution time stamp is mixed
> into the LFSR. ...
>
>  (b) HID event data like the key stroke or the mouse coordinates are
> mixed into the LFSR. ...
>
>  (c) Device drivers may provide data that is mixed into the LFSR. ...

Why into the LFSR instead of into the entropy pool?

> The LRNG allows the TRNG and secondary DRNG mechanism to be changed
> at runtime.

Why? This strikes me as pointless complication.

> * high performance of interrupt handling code: The LRNG impact on the
> interrupt handling has been reduced to a minimum. On one example
> system, the LRNG interrupt handling code executes within an average
> of 65 cycles whereas the existing /dev/random on the same device
> takes about 97 cycles when measuring the execution time of
> add_interrupt_randomness().

Assuming you do this without sacrificing the input mixing, this
would be worth submitting as a separate patch. Saving cycles
on every interrupt definitely looks worth doing.

> * lockless LFSR to collect raw entropy

This too.
