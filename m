Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097D61D90AD
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2020 09:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgESHJx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 19 May 2020 03:09:53 -0400
Received: from mout-p-101.mailbox.org ([80.241.56.151]:19566 "EHLO
        mout-p-101.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgESHJw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 19 May 2020 03:09:52 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 49R6T54bt8zKmbd;
        Tue, 19 May 2020 09:09:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id S1EEOB6BwB-J; Tue, 19 May 2020 09:09:40 +0200 (CEST)
Date:   Tue, 19 May 2020 17:09:29 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Sargun Dhillon <sargun@sargun.me>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: seccomp feature development
Message-ID: <20200519070929.55r3xvybjg6nnbsj@yavin.dot.cyphar.com>
References: <202005181120.971232B7B@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fra7wyraefxcsbgy"
Content-Disposition: inline
In-Reply-To: <202005181120.971232B7B@keescook>
X-Rspamd-Queue-Id: E4B92181D
X-Rspamd-Score: -7.84 / 15.00 / 15.00
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--fra7wyraefxcsbgy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-18, Kees Cook <keescook@chromium.org> wrote:
> ## fd passing
>=20
> Background: seccomp users want to be able to install an fd in a
> monitored process during a user_notif to emulate "open" calls (or
> similar), possibly across security boundaries, etc.
>=20
> On the fd passing front, it seems that gaining pidfd_addfd() is the way
> to go as it allows for generic use not tied to seccomp in particular.
> I expect this feature will be developed orthogonally to seccomp (where
> does this stand, BTW?). However, as Sargun has shown[1], seccomp could
> be friendlier to help with using it. Things that need to be resolved:
>=20
> - report pidnr, or pidfd? It seems the consensus is to pass pidnr, but
>   if we're going to step back and make some design choices here, is
>   there a place for pidfds in seccomp user_notif, in order to avoid
>   needing the user_notif cookie? I think probably not: it's a rather lot
>   of overhead for notifications. It seems it's safe to perform an fd
>   installation with these steps:
> 	- get pidnr from user_notif_recv
> 	- open pidfd from pidnr
> 	- re-verify user_notif cookie is still valid
> 	- send new fd via pidfd
> 	- reply with user_notif_send
> 	- close pidfd

I agree that while it would be conceptually nicer to not need the
user_notif cookie, creating a new pidfd for every notification isn't a
good idea (not to mention that the program may not care about the pid or
pidfd when determining its response -- making the pidfd more of a pain
than anything else).

You'd also need to have special-casing based on the userspace length of
user_notif because old programs wouldn't know they'd have to close the
pidfd returned (which then brings us back to the fact that user_notif
doesn't specify what the usize of the struct is a-la
copy_struct_from_user).

> ## deep argument inspection
>=20
> Background: seccomp users would like to write filters that traverse
> the user pointers passed into many syscalls, but seccomp can't do this
> dereference for a variety of reasons (mostly involving race conditions and
> rearchitecting the entire kernel syscall and copy_from_user() code flows).
>=20
> During the last plumbers and in conversations since, the grudging
> consensus was reached that having seccomp do this for ALL syscalls was
> likely going to be extremely disruptive for very little gain (i.e.
> many things, like pathnames, have differing lifetimes, aliases, unstable
> kernel object references, etc[6]), but that there were a small subset of
> syscalls for which this WOULD be beneficial, and those are the newly
> created "Extensible Argument" syscalls (is there a better name for this
> design? I'm calling it "EA" for the rest of the email), like clone3(),
> openat2(), etc, which pass a pointer and a size:

I called them "extensible struct" syscalls, but "extensible arguments"
is probably a better name. Though if you want to call them EA, make sure
to include the =E2=84=A2. ;)

> long clone3(struct clone_args *cl_args, size_t size);
>=20
> I think it should be possible to extend seccomp to examine this structure
> by appending it to seccomp_data, and allowing filters to examine the
> contents. This means that no BPF language extensions are required for
> seccomp, as I'd still prefer to avoid making the eBPF jump (I don't think
> seccomp's design principles work well with maps, kernel helpers, etc,
> and I think the earlier the examination of using eBPF for user_notif
> bares this out).

While I agree that we don't need to jump to eBPF for this, I do think
we'll need an opcode for is_zeroed() (or bpf_check_uarg_tail_zero()) --
see below.

> In order for this to work, there are a number of prerequisites:
>=20
> - argument caching, in two halves: syscall side and seccomp side:
>   - the EA syscalls needs to include awareness of potential seccomp
>     hooking. i.e. seccomp may have done the copy_from_user() already and
>     kept a cached copy.
>   - seccomp needs to potentially DO the copy_from_user() itself when it
>     hits these syscalls for a given filter, and put it somewhere for
>     later use by the syscall.
>=20
> The argument caching bit is, I think, rather mechanical in nature since
> it's all "just" internal to the kernel: seccomp can likely adjust how it
> allocates seccomp_data (maybe going so far as to have it split across two
> pages with the syscall argument struct always starting on the 2nd page
> boundary), and copying the EA struct into that page, which will be both
> used by the filter and by the syscall. I imagine state tracking ("is
> there a cached EA?", "what is the address of seccomp_data?", "what is
> the address of the EA?") can be associated with the thread struct.

I agree that while this is an important thing to handle properly, it's
internal and probably doesn't deserve the lions share of design
discussion.

> - the sizes of these EA structs are, by design, growable over time.
>   seccomp and its users need to be handle this in a forward and backward
>   compatible way, similar to the design of the EA syscall interface
>   itself.
>=20
> The growing size of the EA struct will need some API design. For filters
> to operate on the contiguous seccomp_data+EA struct, the filter will
> need to know how large seccomp_data is (more on this later), and how
> large the EA struct is. When the filter is written in userspace, it can
> do the math, point into the expected offsets, and get what it needs. For
> this to work correctly in the kernel, though, the seccomp BPF verifier
> needs to know the size of the EA struct as well, so it can correctly
> perform the offset checking (as it currently does for just the
> seccomp_data struct size).
>=20
> Since there is not really any caller-based "seccomp state" associated
> across seccomp(2) calls, I don't think we can add a new command to tell
> the kernel "I'm expecting the EA struct size to be $foo bytes", since
> the kernel doesn't track who "I" is besides just being "current", which
> doesn't take into account the thread lifetime -- if a process launcher
> knows about one size and the child knows about another, things will get
> confused. The sizes really are just associated with individual filters,
> based on the syscalls they're examining. So, I have thoughts on possible
> solutions:
>=20
> - create a new seccomp command SECCOMP_SET_MODE_FILTER2 which uses the
>   EA style so we can pass in more than a filter and include also an
>   array of syscall to size mappings. (I don't like this...)
> - create a new filter flag, SECCOMP_FILTER_FLAG_EXTENSIBLE, which changes
>   the meaning of the uarg from "filter" to a EA-style structure with
>   sizes and pointers to the filter and an array of syscall to size
>   mappings. (I like this slightly better, but I still don't like it.)
> - leverage the EA design and just accept anything <=3D PAGE_SIZE, record
>   the "max offset" value seen during filter verification, and zero-fill
>   the EA struct with zeros to that size when constructing the
>   seccomp_data + EA struct that the filter will examine. Then the seccomp
>   filter doesn't care what any of the sizes are, and userspace doesn't
>   care what any of the sizes are. (I like this as it makes the problems
>   to solve contained entirely by the seccomp infrastructure and does not
>   touch user API, but I worry I'm missing some gotcha I haven't
>   considered.)

Okay, so here is my view on this. I think that the third option is
closest to what I'd like to see. Based on Jann's email, I think we're on
the same page but I'd just like to elaborate it a bit further:

First of all -- ideally, the backward and forward compatibility that EA
syscalls give us should be reflected with seccomp filters being
similarly compatible. Otherwise we're going to run into issues where all
of the hard work with ensuring EA syscalls behave when extended will be
less valuable if seccomp cannot handle it sufficiently. This means that
I would hope that every combination of {old,new} filter/kernel/program
would work on a best-effort (but fail-safe) basis.

In my view, the simplest way (from the kernel side) would be to simply
do what you outlined in (3) -- make all accesses past usize (and even
ksize) be zeroed.

However in order to make an old filter fail-safe on a new kernel with a
new program, we'd need a new opcode which basically does
bpf_check_uarg_tail_zero() after a given offset into the EA struct. This
would punt the fail-safe problem to userspace (libseccomp would need to
generate a check that any unknown-to-the-filter fields are zero). I
don't think this is a decision we can make in-kernel because it might be
that the filter doesn't care about the last field in a struct (and thus
doesn't access it) but we don't know the difference between a field the
filter doesn't care about and a field it doesn't know about.

Another issue which you haven't mentioned here is how do we deal with
pointers inside an EA struct. clone3() already has this with set_tid,
and the thread on user_notif seems to be converging towards having the
user_notif2 struct just contain two pointers to EA structs. We could
punt on this for now, so long as we leave room for us to deal with this
problem in the future. However, I think it would be misguided to enable
deep argument inspection on syscalls which have such entries (such as
clone3) until we've figured out how we want to handle nested pointers --
at the very least because the bpf_check_uarg_tail_zero() opcode
semantics need to consider this problem.

A silly proposal I had was that because the EA would never be bigger
than PAGE_SIZE, we could take the offset into the EA and multiply it by
PAGE_SIZE each time we wanted to do a "dereference" of a pointer in EA.
But this does have a few downsides (seccomp_data can no longer be just a
block of memory, we'd need to translate the offsets, and we'd need to
figure out what the new semantics of the bpf_check_uarg_tail_zero()
should be).

> And then, my age-old concern, that maybe doesn't need a solution... I
> remain plagued by the lack of pathname inspection. But I think the
> ToCToU nature of it means we just cannot do it from seccomp. It does
> make filtering openat2()'s EA struct a bit funny... a filter has no idea
> what path it applies to... but that doesn't matter because the object
> the path points to might change[6] during the syscall. Argh.

I still strongly believe that seccomp is the wrong layer to be doing
this. Yes, we could in theory do some checks like RESOLVE_IN_ROOT (to
detect if a path has changed name on the system), but that sounds like a
complete mess to put inside seccomp.

Yes, this does mean that filtering openat2() is a bit odd -- but so was
filtering openat() by the same token. Really, this is something which
the LSMs were specifically included to do and I think we should let them
handle this problem. Ultimately if/when Landlock gets merged then folks
will be able to have an eBPF-programmable LSM and no longer rely on
seccomp for all their programmable-policy needs.

And as Jann said, you could (with enough effort) come up with filter
rules that do effectively restrict the set of paths a program can access
without needing to look at the path argument. Though I would posit that
using deep argument inspection for that purpose is a little misguided,
as there are better tools for the job (such as LSMs).

> ## changing structure sizes
>=20
> Background: there have been regular needs to add things to various
> seccomp structures. Each come with their own unique pains, and solving
> this as completely as possible in a future-proof way would be very nice.
>=20
> As noted in "fd passing" above, there is a desire to add some useful
> things to the user_notif struct (e.g. thread group pid). Similarly,
> there have been requests in the past (though I can't find any good
> references right now, just my indirect comments[3]) to grow seccomp_data.
> Combined with the EA struct work above, there's a clear need for seccomp
> to reexamine how it deals with its API structures (and how this
> interacts with filters).
>=20
> First, let's consider seccomp_data. If we grow it, the EA struct offset
> will move, based on the deep arg inspection design above. Alternatively,
> we could instead put seccomp_data offset 0, and EA struct at offset
> PAGE_SIZE, and treat seccomp_data itself as an EA struct where we let
> the filter access whatever it thinks is there, with it being zero-filled
> by the kernel. For any values where 0 is valid, there will just need to
> be a "is that field valid?" bit before it:
>=20
> 	unsigned long feature_bits;
> 	unsigned long interesting_thing_1;
> 	unsigned long interesting_thing_2;
> 	unsigned long interesting_thing_3;
> 	...
>=20
> and the filter would check feature_bits...
>=20
> (However, this needs to be carefully considered given that seccomp_data
> is embedded in user_notif... should the EA struct from userspace also be
> copied into user_notif? More thoughts on this below...)
>=20
> For user_notif, I think we need something in and around these options:
>=20
> - make a new API that explicitly follows EA struct design
>   (and while read()/write() might be easier[4], I tend to agree with
>   Jann and we need to stick to ioctl(): as Tycho noted, "read/write is
>   for data". Though I wonder if read() could be used for the notification=
s,
>   which ARE data, and use ioctl() for the responses?)

Note that having EA-style ioctl()s is not unheard of. Daniel Vetter
(added to Cc) mentioned after my EA talk at the last LCA that apparently
graphics has been doing this for years -- maybe we can look at how
they've handled this problem?

> - make a new API that is perf_event_open()-style where fields are
>   explicitly requested, as Sargun suggested[5]. (This looks like it
>   might be complex to construct, but would get us by far the most
>   extensible API.)

Unless I'm mistaken, I think statx(2) might be a better comparison. I
do think this is a reasonable idea, though if we make the struct an EA
(which I recommend) then we'll need to agree on copy_struct_to_user()
semantics.

> - jam whatever we pick into the existing API (we'll be forced to do
>   SOMETHING to make the old API still work, so, I dunno what that will
>   look like until we finish the rest of the design).

If we do the statx-like API then we can just make the old API have an
implied set of requested-fields that match whatever fields were present
before we added the requested-fields approach.

> If we did a requested-fields approach, what would the user_notif event
> block of bytes look like? Would it be entirely dynamic based on the
> initial ioctl()? Another design consideration here is that we don't want
> the kernel doing tons of work (especially copying) and tossing tons
> of stuff into a huge structure that the user doesn't care about. In
> addition to explicit fields, maybe the EA struct could be included,
> perhaps with specified offset/size, so only the portion the user_notif
> user wanted to inspect was copied?

I would be cautious about adding the EA struct -- there is still the
problem of nested pointers (and it might be even crazier to apply
whatever hacks we have for deep argument inspection into the user_notif
API).

> ## syscall bitmasks

I like this idea. :D

> So how would the API for this work? I have two thoughts, and I don't
> think they're exclusive:
>=20
> - new API for "add this syscall to the reject bitmask". We can't really
>   do an "accept" bitmask addition without processing the attached
>   filters...

You could use the accept mask -- take the logical and of all the
filters' masks and that set is the ones you can skip and auto-accept.

> - process attached filters! Each time a filter is added, have the
>   BPF verifier do an analysis to determine if there are any static
>   results, and set bits in the various bitmasks to represent it.
>   i.e. when seccomp is first enabled on a thread, the "accept"
>   bitmask is populated with all syscalls, and for each filter, do
>   [math,simulation,magic] and knock each syscall out of "accept" if
>   it isn't always accepted, and further see if there are any syscalls
>   that are always rejected, and mark those in the "reject" bitmask.

I reckon that both approaches (in parallel) are worthwhile, as the
latter proposal will allow for existing filters to become faster while
the former allows new filters to become much smaller.

The only possible issue I see with a deny bitmask is that we'd have to
make sure that filters generated by libseccomp et al still handle
unknown syscalls correctly (so we don't end up with this feature causing
new filters to become black-lists).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--fra7wyraefxcsbgy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXsOGJgAKCRCdlLljIbnQ
Ek4AAQDLth2Lxg3V/thCBCxnfv7WtAg/VgxMJ3VSz7snYvPezwD/ZVmqkpTCqYh9
Ls24I61Fi6d4laY3iBvwML0okZegkgU=
=W6V5
-----END PGP SIGNATURE-----

--fra7wyraefxcsbgy--
