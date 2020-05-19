Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBFB1D980E
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2020 15:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgESNnS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 19 May 2020 09:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgESNnS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 19 May 2020 09:43:18 -0400
X-Greylist: delayed 23610 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 May 2020 06:43:18 PDT
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6DCC08C5C0;
        Tue, 19 May 2020 06:43:18 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 49RHC63vqzzQjkp;
        Tue, 19 May 2020 15:43:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id 0_nGkEAvCIU6; Tue, 19 May 2020 15:43:10 +0200 (CEST)
Date:   Tue, 19 May 2020 23:42:44 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Kees Cook <keescook@chromium.org>, Tycho Andersen <tycho@tycho.ws>,
        Sargun Dhillon <sargun@sargun.me>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: seccomp feature development
Message-ID: <20200519134244.37bhucyram4n6sjk@yavin.dot.cyphar.com>
References: <202005181120.971232B7B@keescook>
 <20200519070929.55r3xvybjg6nnbsj@yavin.dot.cyphar.com>
 <20200519110128.oot4zzxhivtmk7us@wittgenstein>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bwcyu7f3osyvo2i3"
Content-Disposition: inline
In-Reply-To: <20200519110128.oot4zzxhivtmk7us@wittgenstein>
X-Rspamd-Queue-Id: E911A184D
X-Rspamd-Score: -8.83 / 15.00 / 15.00
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--bwcyu7f3osyvo2i3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-19, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> On Tue, May 19, 2020 at 05:09:29PM +1000, Aleksa Sarai wrote:
> > On 2020-05-18, Kees Cook <keescook@chromium.org> wrote:
> > > - the sizes of these EA structs are, by design, growable over time.
> > >   seccomp and its users need to be handle this in a forward and backw=
ard
> > >   compatible way, similar to the design of the EA syscall interface
> > >   itself.
> > >=20
> > > The growing size of the EA struct will need some API design. For filt=
ers
> > > to operate on the contiguous seccomp_data+EA struct, the filter will
> > > need to know how large seccomp_data is (more on this later), and how
> > > large the EA struct is. When the filter is written in userspace, it c=
an
> > > do the math, point into the expected offsets, and get what it needs. =
For
> > > this to work correctly in the kernel, though, the seccomp BPF verifier
> > > needs to know the size of the EA struct as well, so it can correctly
> > > perform the offset checking (as it currently does for just the
> > > seccomp_data struct size).
> > >=20
> > > Since there is not really any caller-based "seccomp state" associated
> > > across seccomp(2) calls, I don't think we can add a new command to te=
ll
> > > the kernel "I'm expecting the EA struct size to be $foo bytes", since
> > > the kernel doesn't track who "I" is besides just being "current", whi=
ch
> > > doesn't take into account the thread lifetime -- if a process launcher
> > > knows about one size and the child knows about another, things will g=
et
> > > confused. The sizes really are just associated with individual filter=
s,
> > > based on the syscalls they're examining. So, I have thoughts on possi=
ble
> > > solutions:
> > >=20
> > > - create a new seccomp command SECCOMP_SET_MODE_FILTER2 which uses the
> > >   EA style so we can pass in more than a filter and include also an
> > >   array of syscall to size mappings. (I don't like this...)
> > > - create a new filter flag, SECCOMP_FILTER_FLAG_EXTENSIBLE, which cha=
nges
> > >   the meaning of the uarg from "filter" to a EA-style structure with
> > >   sizes and pointers to the filter and an array of syscall to size
> > >   mappings. (I like this slightly better, but I still don't like it.)
> > > - leverage the EA design and just accept anything <=3D PAGE_SIZE, rec=
ord
> > >   the "max offset" value seen during filter verification, and zero-fi=
ll
> > >   the EA struct with zeros to that size when constructing the
> > >   seccomp_data + EA struct that the filter will examine. Then the sec=
comp
> > >   filter doesn't care what any of the sizes are, and userspace doesn't
> > >   care what any of the sizes are. (I like this as it makes the proble=
ms
> > >   to solve contained entirely by the seccomp infrastructure and does =
not
> > >   touch user API, but I worry I'm missing some gotcha I haven't
> > >   considered.)
> >=20
> > Okay, so here is my view on this. I think that the third option is
> > closest to what I'd like to see. Based on Jann's email, I think we're on
> > the same page but I'd just like to elaborate it a bit further:
> >=20
> > First of all -- ideally, the backward and forward compatibility that EA
> > syscalls give us should be reflected with seccomp filters being
> > similarly compatible. Otherwise we're going to run into issues where all
> > of the hard work with ensuring EA syscalls behave when extended will be
> > less valuable if seccomp cannot handle it sufficiently. This means that
> > I would hope that every combination of {old,new} filter/kernel/program
> > would work on a best-effort (but fail-safe) basis.
> >=20
> > In my view, the simplest way (from the kernel side) would be to simply
> > do what you outlined in (3) -- make all accesses past usize (and even
> > ksize) be zeroed.
> >=20
> > However in order to make an old filter fail-safe on a new kernel with a
> > new program, we'd need a new opcode which basically does
> > bpf_check_uarg_tail_zero() after a given offset into the EA struct. This
> > would punt the fail-safe problem to userspace (libseccomp would need to
> > generate a check that any unknown-to-the-filter fields are zero). I
> > don't think this is a decision we can make in-kernel because it might be
> > that the filter doesn't care about the last field in a struct (and thus
> > doesn't access it) but we don't know the difference between a field the
> > filter doesn't care about and a field it doesn't know about.
> >=20
> > Another issue which you haven't mentioned here is how do we deal with
> > pointers inside an EA struct. clone3() already has this with set_tid,
>=20
> It's also passed with a set_tid_size argument so we'd know how large
> set_tid is.

Right, of course -- that's a given. See below for the point I was
making.

> > and the thread on user_notif seems to be converging towards having the
> > user_notif2 struct just contain two pointers to EA structs. We could
> > punt on this for now, so long as we leave room for us to deal with this
> > problem in the future. However, I think it would be misguided to enable
> > deep argument inspection on syscalls which have such entries (such as
> > clone3) until we've figured out how we want to handle nested pointers --
>=20
> We can't really punt on this and should figure this out now. I've
> pointed to this problem in my other mail as well.
> Though I currently fail to see why this should be a huge problem to get
> that working as long as each pointer comes with a known size.

It's not a huge problem necessarily, but we would need to figure out how
we would represent the "nested pointers" in the flattened version which
the seccomp filter will actually offset into. Specifically, my point is
that if we imagine that the proposed new seccomp_data API is:

  [<seccomp_data>][<EA struct contents>]

then any pointers in the EA struct will just be numerical values when
copied. How would write a filter on clone3() that requires the first
entry of set_tid to be 34? You couldn't with this simplified setup. And
unless I'm mistaken, BPF doesn't have pointer dereferences.

So we need to embed the "nested pointers" somehow in the flattened
version of the EA struct. I don't think we can just append them to the
main EA struct -- while you might have the length, that'd mean that
seccomp would generate an array of zeroes whose length is a
user-specified value? And then what about extensible structs that have
their size embedded inside them (as you or someone else suggested for
seccomp user_notif)? How would the eBPF program know the length of the
struct?

Maybe we could have some kind of jump table which the filter could use
(and just have there be a jump table for each embedded struct -- so
multiple embeddings have their own jump tables). So if we imagine some
user-extensible struct like

	struct open_how {
		u64 flags, mode, resolve;
		struct foo *foo;
		struct bar *bar;
		struct baz *baz;
	};

	struct foo {
		u64 foo;
	};

	struct bar {
		u64 bar;
		struct barbaz *barbaz;
	};

	struct barbaz {
		u64 barbaz;
	};

	struct baz {
		u64 baz;
	};

Then we would lay out the seccomp_data as:

	[<seccomp data>][<jump table><open_how>]
		[<jump table><open_how->foo>]
		[<jump table><open_how->bar>]
			[<jump table><open_how->bar->barbaz>]
		[<jump table><open_how->baz>]

The jump table could be as simple as a list of tuples (relative offset
of field in this struct from end of jump table, relative offset of the
copied structure at the end of the jump table). However, it's not
possible to do for-loops in cBPF -- so maybe we'd need to represent the
jump table differently (perhaps having it just be the same size as the
struct).

The above is just a rough sketch, maybe there's a much simpler solution
I'm not seeing.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--bwcyu7f3osyvo2i3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXsPiUQAKCRCdlLljIbnQ
Ep50AP9zx9gjZlyA9d0N/dYnqsRhAbviANs1gxakErGFoVjhtQEAkE7xxR7kr/mm
0z8w3soMNbkm9WxTuM76wyYrwaMYow0=
=eQNz
-----END PGP SIGNATURE-----

--bwcyu7f3osyvo2i3--
