Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82DE8141E90
	for <lists+linux-api@lfdr.de>; Sun, 19 Jan 2020 15:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgASOeD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 19 Jan 2020 09:34:03 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:38009 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726778AbgASOeD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 19 Jan 2020 09:34:03 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id AD73F3B8C;
        Sun, 19 Jan 2020 09:34:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 19 Jan 2020 09:34:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        PqiCNEYryrWQZMtyIzXXe/0VhiZ7CibEmrjyrVFZWV0=; b=DuCGeze7UYcZFAbj
        Hk8iSLBguUnD47hgt0mtfHNrnq2tfNYyJJxLyvxlfLpoVOX24FUYA2IPF1JlMGFa
        4BhQXGwuGpb/aD102tOgzg7UGF40k0UWusasNQHbho5ByENCuMKL/00dyhnY0krs
        vzU5PX+O/lU1uBohHoDWMLr3CS7szoQu50P1fSN5p6QbLB84LzPHwYBjKo+8acDR
        AOdmi/tSaVKEQ8BUZfs08ayGL/lObXuau8E0g3Sq2jlPXpFiK+zvTDbwZVyXO/Ol
        krSywf3I+dPcvkt+m1aTzo2MP+63EwbhLqrsGW3yRtpJ5JKzbcFXOc3763ol6SBZ
        bij6KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=PqiCNEYryrWQZMtyIzXXe/0VhiZ7CibEmrjyrVFZW
        V0=; b=hUlAGWgq0Y4pz//H7FyGa8nS6Q1KaVvQezlkGLLIStH6eyy10COg1Kqjp
        lwT9a18+7FYu/gTUFtmWRqC/hP5LewWXSVHHJPrO7TKbsCe2CSO69OCVnCkxAD9c
        4fndNHv21etv5ooKL9z3V3VJVhBNfM9hFnM8twff3jgd2eXvjiuFu0liR1uM033S
        Njip78Nuuq7TRqeo1ncWcK9u25/TQYnoUmCQACFgEZfA8V9T9CenJq1Ae897Qsr5
        4iDASPlbGRfN4m64BIppifYUqj1f77R6QeB6uT3fouFp/ZELYFsiRcR20j7tf5BG
        t0vsvoA/jEV9D87D18gc/YWhkpmhw==
X-ME-Sender: <xms:12gkXsIo1-YdX-6TVd_8P7xYtjZ2rRoi7oqnk-AVtzxT9E5CiAXfzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudefgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuffhomhgrihhnpeguvghnth
    hrhidrshhonecukfhppeduudehrdduieeirdeggedrheefnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvthenucevlhhushhtvghrufhiiigvpe
    dt
X-ME-Proxy: <xmx:12gkXjFh52h-HpB2Os45jWQMTzuLUXm037J_mS5Edhb1RDhPqOj5zA>
    <xmx:12gkXlqddW3VZUBdQndTtI5nWBk7L4hJxWEQpqfPqw7j1w0EB1hF7g>
    <xmx:12gkXhPTOL5kaz5XoCFMu4buot5WNB8dlpVPOAjJDtfEXIcfoxunwg>
    <xmx:2GgkXuIwKXr_Wr_nqonBuaCbm98djfsf4dDvz0Hm4LnwZCU6GMMwEg>
Received: from mickey.themaw.net (115-166-44-53.dyn.iinet.net.au [115.166.44.53])
        by mail.messagingengine.com (Postfix) with ESMTPA id E02283060AA0;
        Sun, 19 Jan 2020 09:33:54 -0500 (EST)
Message-ID: <7fe21bf7fecb7c22edf59f4605bbe0a11f8cab93.camel@themaw.net>
Subject: Re: [RFC][PATCHSET][CFT] pathwalk cleanups and fixes
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@zeniv.linux.org.uk>, Aleksa Sarai <cyphar@cyphar.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        stable <stable@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Serge Hallyn <serge@hallyn.com>, dev@opencontainers.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sun, 19 Jan 2020 22:33:48 +0800
In-Reply-To: <20200119031423.GV8904@ZenIV.linux.org.uk>
References: <20200101030815.GA17593@ZenIV.linux.org.uk>
         <20200101144407.ugjwzk7zxrucaa6a@yavin.dot.cyphar.com>
         <20200101234009.GB8904@ZenIV.linux.org.uk>
         <20200102035920.dsycgxnb6ba2jhz2@yavin.dot.cyphar.com>
         <20200103014901.GC8904@ZenIV.linux.org.uk>
         <20200108031314.GE8904@ZenIV.linux.org.uk>
         <CAHk-=wgQ3yOBuK8mxpnntD8cfX-+10ba81f86BYg8MhvwpvOMg@mail.gmail.com>
         <20200110210719.ktg3l2kwjrdutlh6@yavin>
         <20200114045733.GW8904@ZenIV.linux.org.uk>
         <20200115135704.eh4atya6fwnikyll@yavin>
         <20200119031423.GV8904@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, 2020-01-19 at 03:14 +0000, Al Viro wrote:
> 	OK, vfs.git #work.namei seems to survive xfstests.  I think
> it cleans the things quite a bit, but it obviously needs more
> review and testing.
> 
> 	Review and testing would be _very_ welcome; it does a lot
> of massage, so there had been a plenty of opportunities to fuck up
> and fail to spot that.  The same goes for profiling - it doesn't
> seem to slow the things down, but that needs to be verified.

I have run my usual tests (the second run of my submount-test is still
going) and they have run through fine.

I spend what time I can looking through the series tomorrow but will
probably need to complete that when I return from my trip to Albany
(Western Australia) some time on Friday.

> 
> 	It does include #work.openat2.  Topology: 17 commits, followed
> by clean merge with #work.openat2, followed by 9 followups.  The
> part is #work.openat2 is as posted by Aleksa; I can repost it, but
> I don't see much point.  Description of the rest follows; patches
> themselves will be in followups.
> 
> part 1: follow_automount() cleanups and fixes.
> 
> 	Quite a bit of that function had been about working around the
> wrong calling conventions of finish_automount().  The problem is that
> finish_automount() misuses the primitive intended for mount(2) and
> friends, where we want to mount on top of the pile, even if something
> has managed to add to that while we'd been trying to lock the
> namespace.
> For automount that's not the right thing to do - there we want to
> discard
> whatever it was going to attach and just cross into what got mounted
> there in the meanwhile (most likely - the results of the same
> automount
> triggered by somebody else).  Current mainline kinda-sorta manages to
> do
> that, but it's unreliable and very convoluted.  Much simpler approach
> is to stop using lock_mount() in finish_automount() and have it bail
> out if something turns out to have been mounted on top where we
> wanted
> to attach.  That allows to get rid of a lot of PITA in the caller.
> Another simplification comes from not trying to cross into the
> results
> of automount - simply ride through the next iteration of the loop and
> let it move into overmount.
> 
> 	Another thing in the same series is divorcing
> follow_automount()
> from nameidata; that'll play later when we get to unifying
> follow_down()
> with the guts of follow_managed().
> 
> 	4 commits, the second one fixes a hard-to-hit race.  The first
> is a prereq for it.
> 
> 1/17	do_add_mount(): lift lock_mount/unlock_mount into callers
> 2/17	fix automount/automount race properly
> 3/17	follow_automount(): get rid of dead^Wstillborn code
> 4/17	follow_automount() doesn't need the entire nameidata
> 
> part 2: unifying mount traversals in pathwalk.
> 
> 	Handling of mount traversal (follow_managed()) is currently
> called
> in a bunch of places.  Each of them is shortly followed by a call of
> step_into() or an open-coded equivalent thereof.  However, the
> locations
> of those step_into() calls are far from preceding follow_managed();
> moreover, that preceding call might happen on different paths that
> converge to given step_into() call.  It's harder to analyse that it
> should
> be (especially when it comes to liveness analysis) and it forces
> rather
> ugly calling conventions on
> lookup_fast()/atomic_open()/lookup_open().
> The series below massages the code to the point when the calls of
> follow_managed() (and __follow_mount_rcu()) move into the beginning
> of
> step_into().
> 
> 5/17	make build_open_flags() treat O_CREAT | O_EXCL as implying
> O_NOFOLLOW
> 	gets EEXIST handling in do_last() past the step_into() call
> there.
> 6/17	handle_mounts(): start building a sane wrapper for
> follow_managed()
> 	rather than mangling follow_managed() itself (and creating
> conflicts
> 	with openat2 series), add a wrapper that will absorb the
> required
> 	interface changes.
> 7/17	atomic_open(): saner calling conventions (return dentry on
> success)
> 	struct path passed to it is pure out parameter; only dentry
> part
> 	ever varies, though - mnt is always nd->path.mnt.  Just return
> 	the dentry on success, and ERR_PTR(-E...) on failure.
> 8/17	lookup_open(): saner calling conventions (return dentry on
> success)
> 	propagate the same change one level up the call chain.
> 9/17	do_last(): collapse the call of path_to_nameidata()
> 	struct path filled in lookup_open() call is eventually given to
> 	handle_mounts(); the only use it has before that is
> path_to_nameidata()
> 	call in "->atomic_open() has actually opened it" case, and
> there
> 	path_to_nameidata() is an overkill - we are guaranteed to
> replace
> 	only nd->path.dentry.  So have the struct path filled only
> immediately
> 	prior to handle_mounts().
> 10/17	handle_mounts(): pass dentry in, turn path into a pure out
> argument
> 	now all callers of handle_mount() are directly preceded by
> filling
> 	struct path it gets.  path->mnt is nd->path.mnt in all cases,
> so we can
> 	pass just the dentry instead and fill path in handle_mount()
> itself.
> 	Some boilerplate gone, path is pure out argument of
> handle_mount()
> 	now.
> 11/17	lookup_fast(): consolidate the RCU success case
> 	massage to gather what will become an RCU case equivalent of
> 	handle_mounts(); basically, that's what we do if revalidate
> succeeds
> 	in RCU case of lookup_fast(), including unlazy and fallback to
> 	handle_mounts() if __follow_mount_rcu() says "it's too tricky".
> 12/17	teach handle_mounts() to handle RCU mode
> 	... and take that into handle_mount() itself.  The other caller
> of
> 	__follow_mount_rcu() is fine with the same fallback (it just
> didn't
> 	bother since it's in the very beginning of pathwalk), switched
> to
> 	handle_mount() as well.
> 13/17	lookup_fast(): take mount traversal into callers
> 	Now we are getting somewhere - both RCU and non-RCU success
> cases of
> 	lookup_fast() are ended with the same return
> handle_mounts(...);
> 	move that to the callers - there it will merge with the
> identical calls
> 	that had been on the paths where we had to do slow lookups.
> 	lookup_fast() returns dentry now.
> 14/17	new step_into() flag: WALK_NOFOLLOW
> 	use step_into() instead of open-coding it in
> handle_lookup_down().
> 	Add a flag for "don't follow symlinks regardless of
> LOOKUP_FOLLOW" for
> 	that (and eventually, I hope, for .. handling).
> 	Now *all* calls of handle_mounts() and step_into() are right
> next to
> 	each other.
> 15/17	fold handle_mounts() into step_into()
> 	... and we can move the call of handle_mounts() into
> step_into(),
> 	getting a slightly saner calling conventions out of that.
> 16/17	LOOKUP_MOUNTPOINT: fold path_mountpointat() into
> path_lookupat()
> 	another payoff from 14/17 - we can teach path_lookupat() to do
> 	what path_mountpointat() used to.  And kill the latter, along
> with
> 	its wrappers.
> 17/17	expand the only remaining call of path_lookup_conditional()
> 	minor cleanup - RIP path_lookup_conditional().  Only one caller
> left.
> 
> At that point we run out of things that can be done without textual
> conflicts
> with openat2 series.  Changes so far:
> 	* mount traversal is taken into step_into().
> 	* lookup_fast(), atomic_open() and lookup_open() calling
> conventions
> are slightly changed.  All of them return dentry now, instead of
> returning
> an int and filling struct path on success.  For lookup_fast() the old
> "0 for cache miss, 1 for cache hit" is replaced with "NULL stands for
> cache
> miss, dentry - for hit".
> 	* step_into() can be called in RCU mode as well.  Takes
> nameidata,
> WALK_... flags, dentry and, in RCU case, corresponding inode and seq
> value.
> Handles mount traversals, decides whether it's a symlink to be
> followed.
> Error => returns -E...; symlink to follow => returns 1, puts symlink
> on stack;
> non-symlink or symlink not to follow => returns 0, moves nd->path to
> new location.
> 	* LOOKUP_MOUNTPOINT introduced; user_path_mountpoint_at() and
> friends
> became calls of user_path_at() et.al. with LOOKUP_MOUNTPOINT in
> flags.
> 
> Next comes the merge with Aleksa's openat2 patchset; everything up to
> that point
> had been non-conflicting with it.  That patchset has been posted
> earlier;
> it's in #work.openat2.  The next series comes on top of the merge.
> 
> part 3: untangling the symlink handling.
> 
> 	Right now when we decide to follow a symlink it happens this
> way:
> 	* step_into() decides that it has been given a symlink that
> needs to
> be followed.
> 	* it calls pick_link(), which pushes the symlink on stack and
> returns 1 on success / -E... on error.  Symlink's mount/dentry/seq is
> stored on stack and the inode is stashed in nd->link_inode.
> 	* step_into() passes that 1 to its callers, which proceed to
> pass it
> up the call chain for several layers.  In all cases we get to
> get_link()
> call shortly afterwards.
> 	* get_link() is called, picks the inode stashed in nd-
> >link_inode
> by the pick_link(), does some checks, touches the atime, etc.
> 	* get_link() either picks the link body out of inode or calls
> ->get_link().  If it's an absolute symlink, we move to the root and
> return
> the relative portion of the body; if it's a relative one - just
> return the
> body.  If it's a procfs-style one, the call of nd_jump_link() has
> been
> made and we'd moved to whatever location is desired.  And return
> NULL,
> same as we do for symlink to "/".
> 	* the caller proceeds to deal with the string returned to it.
> 
> 	The sequence is the same in all cases (nested symlink, trailing
> symlink on lookup, trailing symlink on open), but its pieces are not
> close
> to each other and the bit between the call of pick_link() and
> (inevitable)
> call of get_link() afterwards is not easy to follow.  Moreover, a
> bunch
> of functions (walk_component/lookup_last/do_last) ends up with the
> same
> conventions for return values as step_into().  And those conventions
> (see above) are not pretty - 0/1/-E... is asking for mistakes,
> especially
> when returned 1 is used only to direct control flow on a rather
> twisted
> way to matching get_link() call.  And that path can be seriously
> twisted.
> E.g. when we are trying to open /dev/stdin, we get the following
> sequence:
> 	* path_init() has put us into root and returned "/dev/stdin"
> 	* link_path_walk() has eventually reached /dev and left
> <LAST_NORM, "stdin"> in nd->last_type/nd->last
> 	* we call do_last(), which sees that we have LAST_NORM and
> calls
> lookup_fast().  Let's assume that everything is in dcache; we get the
> dentry of /dev/stdin and proceed to finish_lookup:, where we call
> step_into()
> 	* it's a symlink, we have LOOKUP_FOLLOW, so we decide to pick
> the
> damn thing.  Into the stack it goes and we return 1.
> 	* do_last() sees 1 and returns it.
> 	* trailing_symlink() is called (in the top-level loop) and it
> calls get_link().  OK, we get "/proc/self/fd/0" for body, move to
> root again and return "proc/self/fd/0".
> 	* link_path_walk() is given that string, eventually leading us
> into
> /proc/self/fd, with <LAST_NORM, "0"> left as the component to handle.
> 	* do_last() is called, and similar to the previous case we
> eventually reach the call of step_into() with dentry of
> /proc/self/fd/0.
> 	* _now_ we can discard /dev/stdin from the stack (we'd been
> using its body until now).  It's dropped (from step_into()) and we
> get
> to look at what we'd been given.  A symlink to follow, so on the
> stack
> it goes and we return 1.
> 	* again, do_last() passes 1 to caller
> 	* trailing_symlink() is called and calls get_link().
> 	* this time it's a procfs symlink and its ->get_link() method
> moves us to the mount/dentry of our stdin.  And returns NULL.  But
> the
> fun doesn't stop yet.
> 	* trailing_symlink() returns "" to the caller
> 	* link_path_walk() is called on that and does nothing
> whatsoever.
> 	* do_last() is called and sees LAST_BIND left by the
> get_link().
> It calls handle_dots()
> 	* handle_dots() drops the symlink from stack and returns
> 	* do_last() *FINALLY* proceeds to the point after its call of
> step_into() (finish_open:) and gets around to opening the damn thing.
> 
> 	Making sense of the control flow through all of that is not
> fun,
> to put it mildly; debugging anything in that area can be a massive
> PITA,
> and this example has touched only one of 3 cases.  Arguably, the
> worst
> one, but...  Anyway, it turns out that this code can be massaged to
> considerably saner shape - both in terms of control flow and wrt
> calling
> conventions.
> 
> 1/9	merging pick_link() with get_link(), part 1
> 	prep work: move the "hardening" crap from trailing_symlink()
> into
> get_link() (conditional on the absense of LOOKUP_PARENT in nd-
> >flags).
> We'll be moving the calls of get_link() around quite a bit through
> that
> series, and the next step will be to eliminate trailing_symlink().
> 2/9	merging pick_link() with get_link(), part 2
> 	fold trailing_symlink() into lookup_last() and do_last().
> Now these are returning strings; it's not the final calling
> conventions,
> but it's almost there.  NULL => old 0, we are done.  ERR_PTR(-E...)
> =>
> old -E..., we'd failed.  string => old 1, and the string is the
> symlink
> body to follow.  Just as for trailing_symlink(), "/" and procfs ones
> (where get_link() returns NULL) yield "", so the ugly song and dance
> with no-op trip through link_path_walk()/handle_dots() still remains.
> 3/9	merging pick_link() with get_link(), part 3
> 	elimination of that round-trip.  In *all* cases having
> get_link() return NULL on such symlinks means that we'll proceed to
> drop the symlink from stack and get back to the point near that
> get_link() call - basically, where we would be if it hadn't been
> a symlink at all.  The path by which we are getting there depends
> upon the call site; the end result is the same in all cases - such
> symlinks (procfs ones and symlink to "/") are fully processed by
> the time get_link() returns, so we could as well drop them from the
> stack right in get_link().  Makes life simpler in terms of control
> flow analysis...
> 	And now the calling conventions for do_last() and lookup_last()
> have reached the final shape - ERR_PTR(-E...) for error, NULL for
> "we are done", string for "traverse this".
> 4/9	merging pick_link() with get_link(), part 4
> 	now all calls of walk_component() are followed by the same
> boilerplate - "if it has returned 1, call get_link() and if that
> has returned NULL treat that as if walk_component() has returned 0".
> Eliminate by folding that into walk_component() itself.  Now
> walk_component() return value conventions have joined those of
> do_last()/lookup_last().
> 5/9	merging pick_link() with get_link(), part 5
> 	same as for the previous, only this time the boilerplate
> migrates one level down, into step_into().  Only one caller of
> get_link() left, step_into() has joined the same return value
> conventions.
> 6/9	merging pick_link() with get_link(), part 6
> 	move that thing into pick_link().  Now all traces of
> "return 1 if we are following a symlink" are gone.
> 7/9	finally fold get_link() into pick_link()
> 	ta-da - expand get_link() into the only caller.  As a side
> benefit, we get rid of stashing the inode in nd->link_inode - it
> was done only to carry that piece of information from pick_link()
> to eventual get_link().  That's not the main benefit, though - the
> control flow became considerably easier to reason about.
> 
> For what it's worth, the example above (/dev/stdin) becomes
> 	* path_init() has put us into root and returned "/dev/stdin"
> 	* link_path_walk() has eventually reached /dev and left
> <LAST_NORM, "stdin"> in nd->last_type/nd->last
> 	* we call do_last(), which sees that we have LAST_NORM and
> calls
> lookup_fast().  Let's assume that everything is in dcache; we get the
> dentry of /dev/stdin and proceed to finish_lookup:, where we call
> step_into()
> 	* it's a symlink, we have LOOKUP_FOLLOW, so we decide to pick
> the
> damn thing.  On the stack it goes and we get its body.  Which is
> "/proc/self/fd/0", so we move to root and return "proc/self/fd/0".
> 	* do_last() sees non-NULL and returns it - whether it's an
> error
> or a pathname to traverse, we hadn't reached something we'll be
> opening.
> 	* link_path_walk() is given that string, eventually leading us
> into
> /proc/self/fd, with <LAST_NORM, "0"> left as the component to handle.
> 	* do_last() is called, and similar to the previous case we
> eventually reach the call of step_into() with dentry of
> /proc/self/fd/0.
> 	* _now_ we can discard /dev/stdin from the stack (we'd been
> using its body until now).  It's dropped (from step_into()) and we
> get
> to look at what we'd been given.  A symlink to follow, so on the
> stack
> it goes.   This time it's a procfs symlink and its ->get_link()
> method
> moves us to the mount/dentry of our stdin.  And returns NULL.  So we
> drop symlink from stack and return that NULL to caller.
> 	* that NULL is returned by step_into(), same as if we had just
> moved to a non-symlink.
> 	* do_last() proceeds to open the damn thing.
> 
> part 4.  some mount traversal cleanups.
> 
> 8/9	massage __follow_mount_rcu() a bit
> 	make it more similar to non-RCU counterpart
> 9/9	new helper: traverse_mounts()
> 	the guts of follow_managed() are very similar to
> follow_down().  The calling conventions are different
> (follow_managed()
> works with nameidata, follow_down() - with standalone struct path),
> but the core loop is pretty much the same in both.  Turned that loop
> into a common helper (traverse_mounts()) and since follow_managed()
> becomes a very thin wrapper around it, expand follow_managed() at its
> only call site (in handle_mounts()),
> 
> That's where the series stands right now.  FWIW, at 5.5-rc1
> fs/namei.c
> had been 4867 lines, at the tip of #work.openat2 - 4998, at the
> tip of #work.namei (containing #work.openat2) - 4730...  And IMO
> the thing has become considerably easier to follow.
> 
> What's more, it might be possible to untangle the control flow in
> do_last() now.  Probably a separate series, though - do_last() is
> one hell of a tarpit, so I'm not stepping into it for the rest
> of this cycle...
> 

