Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D42F1D8DBA
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2020 04:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgESCtE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 18 May 2020 22:49:04 -0400
Received: from mout-p-101.mailbox.org ([80.241.56.151]:15742 "EHLO
        mout-p-101.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgESCtE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 18 May 2020 22:49:04 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 49R0hF1DtNzKmcC;
        Tue, 19 May 2020 04:49:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id z1luPqXY7fuj; Tue, 19 May 2020 04:48:55 +0200 (CEST)
Date:   Tue, 19 May 2020 12:48:46 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Sargun Dhillon <sargun@sargun.me>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: seccomp feature development
Message-ID: <20200519024846.b6dr5cjojnuetuyb@yavin.dot.cyphar.com>
References: <202005181120.971232B7B@keescook>
 <CAG48ez1LrQvR2RHD5-ZCEihL4YT1tVgoAJfGYo+M3QukumX=OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cisf46ndtv3jnog6"
Content-Disposition: inline
In-Reply-To: <CAG48ez1LrQvR2RHD5-ZCEihL4YT1tVgoAJfGYo+M3QukumX=OQ@mail.gmail.com>
X-Rspamd-Queue-Id: E19B5168A
X-Rspamd-Score: -9.51 / 15.00 / 15.00
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--cisf46ndtv3jnog6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-19, Jann Horn <jannh@google.com> wrote:
> On Mon, May 18, 2020 at 11:05 PM Kees Cook <keescook@chromium.org> wrote:
> > ## deep argument inspection
> >
> > Background: seccomp users would like to write filters that traverse
> > the user pointers passed into many syscalls, but seccomp can't do this
> > dereference for a variety of reasons (mostly involving race conditions =
and
> > rearchitecting the entire kernel syscall and copy_from_user() code flow=
s).
>=20
> Also, other than for syscall entry, it might be worth thinking about
> whether we want to have a special hook into seccomp for io_uring.
> io_uring is growing support for more and more syscalls, including
> things like openat2, connect, sendmsg, splice and so on, and that list
> is probably just going to grow in the future. If people start wanting
> to use io_uring in software with seccomp filters, it might be
> necessary to come up with some mechanism to prevent io_uring from
> permitting access to almost everything else...
>=20
> Probably not a big priority for now, but something to keep in mind for
> the future.

Indeed. Quite a few people have raised concerns about io_uring and its
debug-ability, but I agree that another less-commonly-mentioned concern
should be how you restrict io_uring(2) from doing operations you've
disallowed through seccomp. Though obviously user_notif shouldn't be
allowed. :D

> > The argument caching bit is, I think, rather mechanical in nature since
> > it's all "just" internal to the kernel: seccomp can likely adjust how it
> > allocates seccomp_data (maybe going so far as to have it split across t=
wo
> > pages with the syscall argument struct always starting on the 2nd page
> > boundary), and copying the EA struct into that page, which will be both
> > used by the filter and by the syscall.
>=20
> We could also do the same kind of thing the eBPF verifier does in
> convert_ctx_accesses(), and rewrite the context accesses to actually
> go through two different pointers depending on the (constant) offset
> into seccomp_data.

My main worry with this is that we'll need to figure out what kind of
offset mathematics are necessary to deal with pointers inside the
extensible struct. As a very ugly proposal, you could make it so that
you multiply the offset by PAGE_SIZE each time you want to dereference
the pointer at that offset (unless we want to add new opcodes to cBPF to
allow us to represent this).

This might even be needed for seccomp user_notif -- given one of the
recent proposals was basically to just add two (extensible) struct
pointers inside the main user_notif struct.

> > I imagine state tracking ("is
> > there a cached EA?", "what is the address of seccomp_data?", "what is
> > the address of the EA?") can be associated with the thread struct.
>=20
> You probably mean the task struct?
>=20
> > The growing size of the EA struct will need some API design. For filters
> > to operate on the contiguous seccomp_data+EA struct, the filter will
> > need to know how large seccomp_data is (more on this later), and how
> > large the EA struct is. When the filter is written in userspace, it can
> > do the math, point into the expected offsets, and get what it needs. For
> > this to work correctly in the kernel, though, the seccomp BPF verifier
> > needs to know the size of the EA struct as well, so it can correctly
> > perform the offset checking (as it currently does for just the
> > seccomp_data struct size).
> >
> > Since there is not really any caller-based "seccomp state" associated
> > across seccomp(2) calls, I don't think we can add a new command to tell
> > the kernel "I'm expecting the EA struct size to be $foo bytes", since
> > the kernel doesn't track who "I" is besides just being "current", which
> > doesn't take into account the thread lifetime -- if a process launcher
> > knows about one size and the child knows about another, things will get
> > confused. The sizes really are just associated with individual filters,
> > based on the syscalls they're examining. So, I have thoughts on possible
> > solutions:
> >
> > - create a new seccomp command SECCOMP_SET_MODE_FILTER2 which uses the
> >   EA style so we can pass in more than a filter and include also an
> >   array of syscall to size mappings. (I don't like this...)
> > - create a new filter flag, SECCOMP_FILTER_FLAG_EXTENSIBLE, which chang=
es
> >   the meaning of the uarg from "filter" to a EA-style structure with
> >   sizes and pointers to the filter and an array of syscall to size
> >   mappings. (I like this slightly better, but I still don't like it.)
> > - leverage the EA design and just accept anything <=3D PAGE_SIZE, record
> >   the "max offset" value seen during filter verification, and zero-fill
> >   the EA struct with zeros to that size when constructing the
> >   seccomp_data + EA struct that the filter will examine. Then the secco=
mp
> >   filter doesn't care what any of the sizes are, and userspace doesn't
> >   care what any of the sizes are. (I like this as it makes the problems
> >   to solve contained entirely by the seccomp infrastructure and does not
> >   touch user API, but I worry I'm missing some gotcha I haven't
> >   considered.)
>=20
> We don't need to actually zero-fill memory for this beyond what the
> kernel supports - AFAIK the existing APIs already say that passing a
> short length is equivalent to passing zeroes, so we can just replace
> all out-of-bounds loads with zeroing registers in the filter.
> The tricky case is what should happen if the userspace program passes
> in fields that the filter doesn't know about. The filter can see the
> length field passed in by userspace, and then just reject anything
> where the length field is bigger than the structure size the filter
> knows about. But maybe it'd be slightly nicer if there was an
> operation for "tell me whether everything starting at offset X is
> zeroes", so that if someone compiles with newer kernel headers where
> the struct is bigger, and leaves the new fields zeroed, the syscalls
> still go through an outdated filter properly.

I think the best way of handling this (without breaking programs
senselessly) is to have filters essentially emulate
copy_struct_from_user() semantics -- which is along the lines of what
you've suggested.

That means in addition to treating all offsets past the end of usize as
being zeroed, we also get filters to only reject programs with usize >
fsize (the size the filter knows) if the trailing (fsize - usize) bytes
are non-zero. Having an opcode for that (a-la bpf_check_uarg_tail_zero)
would be a good idea.

> > And then, my age-old concern, that maybe doesn't need a solution... I
> > remain plagued by the lack of pathname inspection. But I think the
> > ToCToU nature of it means we just cannot do it from seccomp. It does
> > make filtering openat2()'s EA struct a bit funny... a filter has no idea
> > what path it applies to... but that doesn't matter because the object
> > the path points to might change[6] during the syscall. Argh.
>=20
> I don't think seccomp needs to care about paths. Instead, you can use
> one of these three approaches:
>=20
> 1) You can make openat2() the only syscall that is allowed to take
> non-empty path arguments, and restrict it to
> RESOLVE_BENEATH|RESOLVE_IN_ROOT. (For APIs that use AT_EMPTY_PATH, we
> can probably come up with some way to say "this part must be an empty
> string" - e.g. by defining a new bogus placeholder pointer that you
> can use as "empty path", or something like that.) This is basically
> like the old capsicum O_BENEATH stuff, except with seccomp doing the
> enforcement that you're not using absolute paths or things like that.

The only concern I'd have with this is the dfd argument (would you only
permit AT_FDCWD?). If you want to let programs run inside a
pre-configured jail directory then you'd need to white-list only *that*
fd and then block all other syscalls which would let you overwrite that
fd with something else...

> 2) You can create a new mount namespace, then use open_tree() with
> OPEN_TREE_CLONE to create file descriptors to ephemeral bind mounts,
> then sandbox yourself with pivot_root().
> 3) You can use Mickael's landlock, once that's landed.

Or (4), just use LSMs to achieve this goal (which is basically 3, but
applies to all LSMs).

> > ## changing structure sizes
> >
> > Background: there have been regular needs to add things to various
> > seccomp structures. Each come with their own unique pains, and solving
> > this as completely as possible in a future-proof way would be very nice.
> >
> > As noted in "fd passing" above, there is a desire to add some useful
> > things to the user_notif struct (e.g. thread group pid). Similarly,
> > there have been requests in the past (though I can't find any good
> > references right now, just my indirect comments[3]) to grow seccomp_dat=
a.
>=20
> This thing (which hasn't landed so far, but would be a really awesome
> feature) needed to add stuff to seccomp_data:
> <https://lore.kernel.org/linux-api/20181029112343.27454-1-msammler@mpi-sw=
s.org/>
>=20
> > Combined with the EA struct work above, there's a clear need for seccomp
> > to reexamine how it deals with its API structures (and how this
> > interacts with filters).
> >
> > First, let's consider seccomp_data. If we grow it, the EA struct offset
> > will move, based on the deep arg inspection design above. Alternatively,
> > we could instead put seccomp_data offset 0, and EA struct at offset
> > PAGE_SIZE, and treat seccomp_data itself as an EA struct where we let
> > the filter access whatever it thinks is there, with it being zero-filled
> > by the kernel. For any values where 0 is valid, there will just need to
> > be a "is that field valid?" bit before it:
> >
> >         unsigned long feature_bits;
> >         unsigned long interesting_thing_1;
> >         unsigned long interesting_thing_2;
> >         unsigned long interesting_thing_3;
> >         ...
> >
> > and the filter would check feature_bits...
>=20
> (Apart from the user_notif stuff, those feature bits would not
> actually have to exist in memory; they could be inlined while loading
> the program. Actually, not even the registers would have to exist in a
> seccomp_data struct in memory, we could just replace the loads with
> reads from the pt_regs, too.)
>=20
> > (However, this needs to be carefully considered given that seccomp_data
> > is embedded in user_notif... should the EA struct from userspace also be
> > copied into user_notif? More thoughts on this below...)
> >
> > For user_notif, I think we need something in and around these options:
> >
> > - make a new API that explicitly follows EA struct design
> >   (and while read()/write() might be easier[4], I tend to agree with
> >   Jann and we need to stick to ioctl(): as Tycho noted, "read/write is
> >   for data". Though I wonder if read() could be used for the notificati=
ons,
> >   which ARE data, and use ioctl() for the responses?)
>=20
> Just as a note: If we use read() there, we'll never be able to
> transfer things like FDs through that API.

And we run into the age-old "read() for management can be a bit hairy"
problem.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--cisf46ndtv3jnog6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXsNJCgAKCRCdlLljIbnQ
Ehu8AP982wzZyHbdAM6I7gx48pcJa7+8hVC7DBkHdx8mhHufmwD/YVHuF81GLO02
Kzj35J3Hl3xy9RKp9t5e3wd5R3IosQM=
=PqJn
-----END PGP SIGNATURE-----

--cisf46ndtv3jnog6--
