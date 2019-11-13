Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDBF9FA9FC
	for <lists+linux-api@lfdr.de>; Wed, 13 Nov 2019 07:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfKMGCx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 13 Nov 2019 01:02:53 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39760 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfKMGCw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 13 Nov 2019 01:02:52 -0500
Received: by mail-qk1-f196.google.com with SMTP id 15so754521qkh.6;
        Tue, 12 Nov 2019 22:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=phY5nYA9dHfZmr9N/f2WhSW/Yk2EVx6rjISS971Sg2o=;
        b=mXfCrazN9OmG7u9ZHylHgcIWpfHsn9ZPDWi5eVrh3USyFDSrlAIqK3YbWi5Gt1I5G3
         gjKQVXWCRSAx1O8yY+IaIoaHEwVKKfiKPxQbxhF6W9APf5JXQD/PPVvO57Q5YPNnK8vp
         94vMbmLlH2ISX9divPjKRhO1JH2Sh1xrervXN7P0Y1rmfBx+hiYXYFyaJ4cZz7KDmVAo
         e7sKwwxFqGRq7fTU4aVaQoSGDyDXYi1ohraFQUADPpcyaDhkyyHf/cIejD4m0zEUzQyc
         JnO4hfzmk6S4bDUKGe34KJ5IfGeoDOSOEgGIpXL0d3lKy7faUbJBJVXRvDzZLkQCzfW+
         AvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=phY5nYA9dHfZmr9N/f2WhSW/Yk2EVx6rjISS971Sg2o=;
        b=ge6GjaogSgKb2Uo8ePd2rF3WIjpMuFcCcKrMM3i/2uZV2inC2edbYiV4MEZ8JfUiRw
         rqtdtRdWSanNfdohy6W+Qggf35xc86ExFdCBlxxcoIwOdF/G1SjOLnV9/Li4OFi0f50G
         x85CYrav6cIqMyfF11x4s76Xcfd4BUqrTnNHnsQOcQf3Kg3uypicqqEZpZrKtWrRvzHf
         8Fs8gmWhBqQ12j3NTwdvFGgibUQ+WVGhmKXHcw1TVxxkvIGoJLwzfg0isbg3NdZhUS+U
         GN8QVa3/B2AGSPDE4TOFuRdFk9ZmOJygqL2a8nmmTAw1rlIa1dpWjtZB2NMAYcJoWMGg
         S1TA==
X-Gm-Message-State: APjAAAUUPn7nj9WIbQA2ezSkuRy4whu9zUkG1BhzoJv8hUQyId12lzeZ
        fqd42KoJxL6MXQGVy6wAgYtQa3U0e6YFBxpRxmM=
X-Google-Smtp-Source: APXvYqwpTO3SSm8dLQNU/ZVFUrLYX4ux5vxjme0dp8ULBuaBBoEv6u2hZ10eTvWolnIf5b5PhbUqSsH2wC5NXzEq7Po=
X-Received: by 2002:a37:7c81:: with SMTP id x123mr1137940qkc.212.1573624971655;
 Tue, 12 Nov 2019 22:02:51 -0800 (PST)
MIME-Version: 1.0
References: <6157374.ptSnyUpaCn@positron.chronox.de> <3385183.Cb3iLDTLdO@positron.chronox.de>
 <556c89ae-4272-970d-1644-cb77dc3c7946@gmail.com> <9152597.fJySsU3eCD@positron.chronox.de>
In-Reply-To: <9152597.fJySsU3eCD@positron.chronox.de>
From:   "Alexander E. Patrakov" <patrakov@gmail.com>
Date:   Wed, 13 Nov 2019 11:02:40 +0500
Message-ID: <CAN_LGv3LUjJ=8ZZxaJ=c7uDPb=ayvCNPE-UshxgBUK-Jf7qNmQ@mail.gmail.com>
Subject: Re: [PATCH v24 11/12] LRNG - add SP800-90B compliant health tests
To:     =?UTF-8?Q?Stephan_M=C3=BCller?= <smueller@chronox.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
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

=D1=81=D1=80, 13 =D0=BD=D0=BE=D1=8F=D0=B1. 2019 =D0=B3. =D0=B2 05:38, Steph=
an M=C3=BCller <smueller@chronox.de>:
>
> Am Dienstag, 12. November 2019, 20:58:32 CET schrieb Alexander E. Patrako=
v:
>
> Hi Alexander,
>
> > > +config LRNG_HEALTH_TESTS
> > > +   bool "Enable noise source online health tests"
> > > +   help
> > > +     The online health tests validate the noise source at
> > > +     runtime for fatal errors. These tests include SP800-90B
> > > +     compliant tests which are invoked if the system is booted
> > > +     with fips=3D1. In case of fatal errors during active
> > > +     SP800-90B tests, the issue is logged and the noise
> > > +     data is discarded. These tests are required for full
> > > +     compliance with SP800-90B.
> >
> > How have you tested that these tests work at runtime? Maybe add some
> > code under a new CONFIG item that depends on CONFIG_BROKEN that
> > deliberately botches the RNG and triggers failures?
>
>
> I am unable to find sensible information about CONFIG_BROKEN in the recen=
t
> kernel tree.
>
> Do you happen to have a pointer on how that option is to be used?

This option is not used on its own. You create a new option,
CONFIG_TEST_LRNG_FAILURE_MODE or something like that, and put your
code under the ifdef guarded by that option. And then, to prevent
ordinary users and allyesconfig from selecting it, in Kconfig you say:
"depends on BROKEN". This way, the option becomes unselectable in
menuconfig but still works as intended when added manually to .config
(obviously, with the BROKEN dependency removed locally).

Definition: https://github.com/torvalds/linux/blob/9c7db5004280767566e91a33=
445bf93aa479ef02/init/Kconfig#L68
Example usage: https://github.com/torvalds/linux/blob/c87237110f2553b4200a8=
b3401a01198edfcf0d9/drivers/gpu/drm/i915/Kconfig.debug#L166

--
Alexander E. Patrakov
