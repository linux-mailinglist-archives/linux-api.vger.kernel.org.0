Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB4D3FA92F
	for <lists+linux-api@lfdr.de>; Wed, 13 Nov 2019 05:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfKMEsq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 12 Nov 2019 23:48:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:39020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbfKMEsp (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 12 Nov 2019 23:48:45 -0500
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17D472245D
        for <linux-api@vger.kernel.org>; Wed, 13 Nov 2019 04:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573620523;
        bh=JekA7T9hI81Ns3VAxm1JGt/jGYHRceTz9qVWnShkahI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q6e6dqau9j98a1EJ39WHqDrzePZYLryhqHq5//h1qY76V083EtVU9mJSptdPXpe3x
         jPocFR0TknPA+PiYmMDCNPVwt18KrPpjgg5E20bi0MbDLFPCxXDm3BSsbQhkpm/O66
         JWRu5b5dyhiWgVND6CqvQpo+JqRYFgPFWkCmXJ0Y=
Received: by mail-wm1-f46.google.com with SMTP id q70so488983wme.1
        for <linux-api@vger.kernel.org>; Tue, 12 Nov 2019 20:48:43 -0800 (PST)
X-Gm-Message-State: APjAAAWJYEWxOnjgu1PIFjymIozUENW9u04GlI/WIuHvzy3+WLqwSNsM
        6wUBzEW6ouBAN1yNY9A7lB0FxDx36Dfv+yC/2+QSaw==
X-Google-Smtp-Source: APXvYqzHZAN8kHsTOGKXhrhA+lp57rKvesbhM9l64m01LPZyOzPCuYxVyYoQbLnO6Mm1Cg9oVrUR29QTzEdhyTF94Do=
X-Received: by 2002:a05:600c:3cf:: with SMTP id z15mr844908wmd.76.1573620521471;
 Tue, 12 Nov 2019 20:48:41 -0800 (PST)
MIME-Version: 1.0
References: <6157374.ptSnyUpaCn@positron.chronox.de> <CALCETrVBzuOsDfaz5y3V4v+6xmeWufOYsOGnpZrRju6Pfsi6gg@mail.gmail.com>
 <3208655.cZiRAY37Id@positron.chronox.de>
In-Reply-To: <3208655.cZiRAY37Id@positron.chronox.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 12 Nov 2019 20:48:30 -0800
X-Gmail-Original-Message-ID: <CALCETrVHdauN2ptZLSYAUDm=S3OGkxq=iH4qGxCuH0XCMKjGkQ@mail.gmail.com>
Message-ID: <CALCETrVHdauN2ptZLSYAUDm=S3OGkxq=iH4qGxCuH0XCMKjGkQ@mail.gmail.com>
Subject: Re: [PATCH v24 00/12] /dev/random - a new approach with full
 SP800-90B compliance
To:     =?UTF-8?Q?Stephan_M=C3=BCller?= <smueller@chronox.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
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

On Tue, Nov 12, 2019 at 8:25 PM Stephan M=C3=BCller <smueller@chronox.de> w=
rote:
>
> Am Dienstag, 12. November 2019, 16:33:59 CET schrieb Andy Lutomirski:
>
> Hi Andy,
>
> > On Mon, Nov 11, 2019 at 11:13 AM Stephan M=C3=BCller <smueller@chronox.=
de> wrote:
> > > The following patch set provides a different approach to /dev/random =
which
> > > is called Linux Random Number Generator (LRNG) to collect entropy wit=
hin
> > > the Linux kernel. The main improvements compared to the existing
> > > /dev/random is to provide sufficient entropy during boot time as well=
 as
> > > in virtual environments and when using SSDs. A secondary design goal =
is
> > > to limit the impact of the entropy collection on massive parallel sys=
tems
> > > and also allow the use accelerated cryptographic primitives. Also, al=
l
> > > steps of the entropic data processing are testable.
> >
> > This is very nice!
> >
> > > The LRNG patch set allows a user to select use of the existing /dev/r=
andom
> > > or the LRNG during compile time. As the LRNG provides API and ABI
> > > compatible interfaces to the existing /dev/random implementation, the
> > > user can freely chose the RNG implementation without affecting kernel=
 or
> > > user space operations.
> > >
> > > This patch set provides early boot-time entropy which implies that no
> > > additional flags to the getrandom(2) system call discussed recently o=
n
> > > the LKML is considered to be necessary.
> >
> > I'm uneasy about this.  I fully believe that, *on x86*, this works.
> > But on embedded systems with in-order CPUs, a single clock, and very
> > lightweight boot processes, most or all of boot might be too
> > deterministic for this to work.
> >
> > I have a somewhat competing patch set here:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=
=3Drandom
> > /kill-it
> >
> > (Ignore the "horrible test hack" and the debugfs part.)
> >
> > The basic summary is that I change /dev/random so that it becomes
> > functionally identical to getrandom(..., 0) -- in other words, it
> > blocks until the CRNG is initialized but is then identical to
> > /dev/urandom.  And I add getrandom(...., GRND_INSECURE) that is
> > functionally identical to the existing /dev/urandom: it always returns
> > *something* immediately, but it may or may not actually be
> > cryptographically random or even random at all depending on system
> > details.
> >
> > In other words, my series simplifies the ABI that we support.  Right
> > now, we have three ways to ask for random numbers with different
> > semantics and we need to have to RNGs in the kernel at all time.  With
> > my changes, we have only two ways to ask for random numbers, and the
> > /dev/random pool is entirely gone.
> >
> > Would you be amenable to merging this into your series (i.e. either
> > merging the code or just the ideas)?  This would let you get rid of
> > things like the compile-time selection of the blocking TRNG, since the
> > blocking TRNG would be entirely gone.
>
> I pulled your code and found the following based on my explanation that I
> would suggest to keep the TRNG at least as an option.
>
> - 7d54ef8512b06baf396f12584f7f48a9558ecd0f does not seem applicable:

Not surprising.  It's just a cleanup to the existing code, and I doubt
you inherited the oddity I'm fixing.

> - 6a26a3146e5fb90878dca9fde8caa1ca4233156a: My handler for /dev/urandom a=
nd
> getrandom(..., 0) are using one callback which issues a warning in both u=
se
> cases (see lrng_sdrng_read). So I think this patch may not be applicable =
as
> the LRNG code implements warning about being unseeded.

Probably true.

What is the actual semantics of /dev/urandom with your series applied?
 Is there any situation in which it will block?

>
> - 3e8e159da49b44ae0bb08e68fa2be760722fa033: I am happy to take that code =
which
> would almost directly apply. The last hunk however would be:
>
> if (!(flags & GRND_INSECURE) && unlikely(!lrng_state_operational())) {
>
> =3D=3D> Shall I apply it to my code base? If yes, how shall the changes t=
o
> random.h be handled?
>

This might be a question for Ted.  Once the merge window opens, I'll
resubmit it.

>
> - 920e97e7fc508e6f0da9c7dec94c8073fd63ab4d: I would pass on this patch du=
e to
> the following: it unconditionally starts removing the access to the TRNG =
(the
> LRNG's logical equivalent to the blocking_pool). As patch 10/12 of the LR=
NG
> patch series provides the TRNG that is a compile time option, your patch =
would
> logically and functionally be equivalent when deselecting
> CONFIG_LRNG_TRNG_SUPPORT in the LRNG without any further changes to the L=
RNG
> code.

Given your previous email about the TRNG, I'm wondering what the API
for the TRNG should be.  I am willing to grant that there are users
who need a TRNG for various reasons, and that not all of them can use
hwrng.  (And the current hwrng API is pretty bad.)  But I'm not
convinced that /dev/random or getrandom(..., GRND_RANDOM) is a
reasonable way to access it.  A blocking_pool-style TRNG is a very
limited resource, and I think it could make sense to require some sort
of actual permission to use it.  GRND_RANDOM has no access control at
all, and everyone expects /dev/random to be world-readable.  The most
widespread user of /dev/random that I know of is gnupg, and gnupg
really should not be using it.

Would it make sense to have a /dev/true_random that is 0400 by default
for users who actually need it?  Then /dev/random and GRND_RANDOM
could work as they do with my patch, and maybe it does the right thing
for everyone.

>
> - 693b9ffdf0fdc93456b5ad293ac05edf240a531b: This patch is applicable to t=
he
> LRNG. In case CONFIG_LRNG_TRNG_SUPPORT is not set, the TRNG is not presen=
t.
> Yet, the /dev/random and getrandom(GRND_RANDOM) would behave blocked unti=
l
> fully initialized. I have now added the general blocking until the LRNG i=
s
> fully initialized to the common /dev/random and getrandom(GRND_RANDOM)
> interface function of lrng_trng_read_common. With that, the LRNG would be
> fully equivalent to this patch if CONFIG_LRNG_TRNG_SUPPORT is not set.

Sounds reasonable.

> By making the TRNG compile-time selectable, I was hoping to serve all use=
rs: I
> wanted to cover the conclusions of the discussion to remove the blocking_=
pool.
> On the other hand, however, I want to support requirements that need the
> blocking behavior.

I find it odd that /dev/random would be either a TRNG or not a TRNG
depending on kernel configuration.  For the small fraction of users
that actually want a TRNG, wouldn't it be better to have an interface
that fails outright if the TRNG is not enabled?

--Andy
