Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DDA1D98A0
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2020 15:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgESNyR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 19 May 2020 09:54:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:46244 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbgESNyR (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 19 May 2020 09:54:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A8951AC64;
        Tue, 19 May 2020 13:54:17 +0000 (UTC)
Date:   Tue, 19 May 2020 23:53:56 +1000
From:   Aleksa Sarai <asarai@suse.de>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Matt Denton <mpdenton@google.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-api@vger.kernel.org
Subject: Re: seccomp feature development
Message-ID: <20200519135356.zmqvtzrxd63dgg4z@yavin.dot.cyphar.com>
References: <202005181120.971232B7B@keescook>
 <20200519070929.55r3xvybjg6nnbsj@yavin.dot.cyphar.com>
 <20200519110128.oot4zzxhivtmk7us@wittgenstein>
 <20200519134244.37bhucyram4n6sjk@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4un2g5pztqv57r4x"
Content-Disposition: inline
In-Reply-To: <20200519134244.37bhucyram4n6sjk@yavin.dot.cyphar.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--4un2g5pztqv57r4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-19, Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2020-05-19, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> > On Tue, May 19, 2020 at 05:09:29PM +1000, Aleksa Sarai wrote:
> > > On 2020-05-18, Kees Cook <keescook@chromium.org> wrote:
> > > > - the sizes of these EA structs are, by design, growable over time.
> > > >   seccomp and its users need to be handle this in a forward and bac=
kward
> > > >   compatible way, similar to the design of the EA syscall interface
> > > >   itself.
> > > >=20
> > > > The growing size of the EA struct will need some API design. For fi=
lters
> > > > to operate on the contiguous seccomp_data+EA struct, the filter will
> > > > need to know how large seccomp_data is (more on this later), and how
> > > > large the EA struct is. When the filter is written in userspace, it=
 can
> > > > do the math, point into the expected offsets, and get what it needs=
=2E For
> > > > this to work correctly in the kernel, though, the seccomp BPF verif=
ier
> > > > needs to know the size of the EA struct as well, so it can correctly
> > > > perform the offset checking (as it currently does for just the
> > > > seccomp_data struct size).
> > > >=20
> > > > Since there is not really any caller-based "seccomp state" associat=
ed
> > > > across seccomp(2) calls, I don't think we can add a new command to =
tell
> > > > the kernel "I'm expecting the EA struct size to be $foo bytes", sin=
ce
> > > > the kernel doesn't track who "I" is besides just being "current", w=
hich
> > > > doesn't take into account the thread lifetime -- if a process launc=
her
> > > > knows about one size and the child knows about another, things will=
 get
> > > > confused. The sizes really are just associated with individual filt=
ers,
> > > > based on the syscalls they're examining. So, I have thoughts on pos=
sible
> > > > solutions:
> > > >=20
> > > > - create a new seccomp command SECCOMP_SET_MODE_FILTER2 which uses =
the
> > > >   EA style so we can pass in more than a filter and include also an
> > > >   array of syscall to size mappings. (I don't like this...)
> > > > - create a new filter flag, SECCOMP_FILTER_FLAG_EXTENSIBLE, which c=
hanges
> > > >   the meaning of the uarg from "filter" to a EA-style structure with
> > > >   sizes and pointers to the filter and an array of syscall to size
> > > >   mappings. (I like this slightly better, but I still don't like it=
=2E)
> > > > - leverage the EA design and just accept anything <=3D PAGE_SIZE, r=
ecord
> > > >   the "max offset" value seen during filter verification, and zero-=
fill
> > > >   the EA struct with zeros to that size when constructing the
> > > >   seccomp_data + EA struct that the filter will examine. Then the s=
eccomp
> > > >   filter doesn't care what any of the sizes are, and userspace does=
n't
> > > >   care what any of the sizes are. (I like this as it makes the prob=
lems
> > > >   to solve contained entirely by the seccomp infrastructure and doe=
s not
> > > >   touch user API, but I worry I'm missing some gotcha I haven't
> > > >   considered.)
> > >=20
> > > Okay, so here is my view on this. I think that the third option is
> > > closest to what I'd like to see. Based on Jann's email, I think we're=
 on
> > > the same page but I'd just like to elaborate it a bit further:
> > >=20
> > > First of all -- ideally, the backward and forward compatibility that =
EA
> > > syscalls give us should be reflected with seccomp filters being
> > > similarly compatible. Otherwise we're going to run into issues where =
all
> > > of the hard work with ensuring EA syscalls behave when extended will =
be
> > > less valuable if seccomp cannot handle it sufficiently. This means th=
at
> > > I would hope that every combination of {old,new} filter/kernel/program
> > > would work on a best-effort (but fail-safe) basis.
> > >=20
> > > In my view, the simplest way (from the kernel side) would be to simply
> > > do what you outlined in (3) -- make all accesses past usize (and even
> > > ksize) be zeroed.
> > >=20
> > > However in order to make an old filter fail-safe on a new kernel with=
 a
> > > new program, we'd need a new opcode which basically does
> > > bpf_check_uarg_tail_zero() after a given offset into the EA struct. T=
his
> > > would punt the fail-safe problem to userspace (libseccomp would need =
to
> > > generate a check that any unknown-to-the-filter fields are zero). I
> > > don't think this is a decision we can make in-kernel because it might=
 be
> > > that the filter doesn't care about the last field in a struct (and th=
us
> > > doesn't access it) but we don't know the difference between a field t=
he
> > > filter doesn't care about and a field it doesn't know about.
> > >=20
> > > Another issue which you haven't mentioned here is how do we deal with
> > > pointers inside an EA struct. clone3() already has this with set_tid,
> >=20
> > It's also passed with a set_tid_size argument so we'd know how large
> > set_tid is.
>=20
> Right, of course -- that's a given. See below for the point I was
> making.
>=20
> > > and the thread on user_notif seems to be converging towards having the
> > > user_notif2 struct just contain two pointers to EA structs. We could
> > > punt on this for now, so long as we leave room for us to deal with th=
is
> > > problem in the future. However, I think it would be misguided to enab=
le
> > > deep argument inspection on syscalls which have such entries (such as
> > > clone3) until we've figured out how we want to handle nested pointers=
 --
> >=20
> > We can't really punt on this and should figure this out now. I've
> > pointed to this problem in my other mail as well.
> > Though I currently fail to see why this should be a huge problem to get
> > that working as long as each pointer comes with a known size.
>=20
> It's not a huge problem necessarily, but we would need to figure out how
> we would represent the "nested pointers" in the flattened version which
> the seccomp filter will actually offset into. Specifically, my point is
> that if we imagine that the proposed new seccomp_data API is:
>=20
>   [<seccomp_data>][<EA struct contents>]
>=20
> then any pointers in the EA struct will just be numerical values when
> copied. How would write a filter on clone3() that requires the first
> entry of set_tid to be 34? You couldn't with this simplified setup. And
> unless I'm mistaken, BPF doesn't have pointer dereferences.
>=20
> So we need to embed the "nested pointers" somehow in the flattened
> version of the EA struct. I don't think we can just append them to the
> main EA struct -- while you might have the length, that'd mean that
> seccomp would generate an array of zeroes whose length is a
> user-specified value? And then what about extensible structs that have
> their size embedded inside them (as you or someone else suggested for
> seccomp user_notif)? How would the eBPF program know the length of the
> struct?
>=20
> Maybe we could have some kind of jump table which the filter could use
> (and just have there be a jump table for each embedded struct -- so
> multiple embeddings have their own jump tables). So if we imagine some
> user-extensible struct like
>=20
> 	struct open_how {
> 		u64 flags, mode, resolve;
> 		struct foo *foo;
> 		struct bar *bar;
> 		struct baz *baz;
> 	};
>=20
> 	struct foo {
> 		u64 foo;
> 	};
>=20
> 	struct bar {
> 		u64 bar;
> 		struct barbaz *barbaz;
> 	};
>=20
> 	struct barbaz {
> 		u64 barbaz;
> 	};
>=20
> 	struct baz {
> 		u64 baz;
> 	};

Sorry, I omitted all of the _size fields for extensibility. Just imagine
I added them (or that the u64s represent the size).

> Then we would lay out the seccomp_data as:
>=20
> 	[<seccomp data>][<jump table><open_how>]
> 		[<jump table><open_how->foo>]
> 		[<jump table><open_how->bar>]
> 			[<jump table><open_how->bar->barbaz>]
> 		[<jump table><open_how->baz>]
>=20
> The jump table could be as simple as a list of tuples (relative offset
> of field in this struct from end of jump table, relative offset of the
> copied structure at the end of the jump table). However, it's not
> possible to do for-loops in cBPF -- so maybe we'd need to represent the
> jump table differently (perhaps having it just be the same size as the
> struct).
>=20
> The above is just a rough sketch, maybe there's a much simpler solution
> I'm not seeing.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--4un2g5pztqv57r4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAl7D5O8ACgkQnhiqJn3b
jbTv1xAAiUXQWimkrqn9Uz+HOtUS6/JFAwWLX+JIW7IKAcN8E/C5J79WvtCIXASx
2ALN7a/V6LJt+IExYu3OC10031Qd41HVheLFCnqEXAbysl6xIL7C7y9IhkvjnSb7
FDVG9DUxM9JG7RTuTDZCQAPsIq7wzhfNgJxvFZ3wb0udW0xAMC1ww7qzXO8UntgH
nH001QvvhNqxl36r7Zh3ObD4PtUQCpuFNTMQIidQWoYjWvfzywosIzfWaXk8dOXt
hVpRx8h4Vx4UEFjmzw5Rs5Ev1mNLGdVGRiSZY+SqhsqdUTobxkfuPKSF80/59CvE
BlrKZs6ELpV0KX2vZsbgUcuabDjxKBD9429uo7ffRVu0bodgliVyBVY71HfRCDSZ
tu394dbVVPvWtstVRoFNxHKffkZRF0n1SHMoVQwms8D+UV+arsDwipE8ba+Ivpxl
PQ5mpbSqJWt8nhxw4yMmogzGy/dPduRw0+0OlkJkIPazj6HS1JvZs6/sJM81U+uO
e6RncHOtAvF1pbwZ/6TX+47WC9Wvx7FAJvOxZ5g/0ossmZn4rJvZhMkMglTxozaW
bvnhdLIhMK4rbq0xe7QD+o2tFemeoRNSzdJc8f+pXkBJy01DfnIhlTzBufaGbZui
RoJy+URf1EOHBt4h+471ixCVaWH4cCojZE5kVjLgJhgJWDwiAeg=
=vfZP
-----END PGP SIGNATURE-----

--4un2g5pztqv57r4x--
