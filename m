Return-Path: <linux-api+bounces-6538-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sp4dKiGnIWqmKgEAu9opvQ
	(envelope-from <linux-api+bounces-6538-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 18:26:09 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FB9641D0C
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 18:26:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=1wt.eu header.s=mail header.b=TElWUM0s;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6538-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6538-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=1wt.eu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44327306EB2B
	for <lists+linux-api@lfdr.de>; Thu,  4 Jun 2026 16:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A6A3CAA2F;
	Thu,  4 Jun 2026 16:09:58 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3751139734D;
	Thu,  4 Jun 2026 16:09:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589398; cv=none; b=t+wY6Zs3WqFQ3zBHhf5ijd6TqZWBPY4bCRFASeX2h1Uoa+zwpQODcRPeyePQc4ItdRB1w3intXaZINHK+pmIQRYJknCV76BmyLtZafPyNbb/zuJ/iHfbOGrelcJ8Q1bBaJm/6vR1zXwpfm00rQSFhhdHxR4dB3KW8s/TPSwCTrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589398; c=relaxed/simple;
	bh=OumF9YU/W2DC9TQahWgOlbC3nl6qPntnyIOFO8hcbT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qg/4tAPZtJ4nEpZJURUccfaTVa1wahJDi3nBq9rr2sGN0ZZUo90TBOWz2f9cy/PJaBsDOxWhwl10WPHJ11/kSM4R90NHP+nKEnNZsJPimZqbm6AOetVHFMd9OZzXjoNJdgNFAKEuWORXi96WCuZRCrvzqk5kSCI8jLCi8x4TuM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=TElWUM0s; arc=none smtp.client-ip=51.159.59.229
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1780589394; bh=y/e/KFECQ0nVdisZcQGbObkQi59gFXxoiirNSRFoeAU=;
	h=From:Message-ID:From;
	b=TElWUM0sOEBUzobw2i+ObteZadlxtBDeRmHqCRPCvh5A8JvN3VVhCrmkxgCvned89
	 gmmyp3Pp+k3E4V5MOhBKRMkYMNO+fi3SWg5c7mqTFtLTt5SRePYS6NF8eqRvdPqZMy
	 zGRiGXJVHF2QJGmtNzwVRIVXrzMUAuNzP2a//igE=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 8DE61C0BB1;
	Thu, 04 Jun 2026 18:09:54 +0200 (CEST)
Date: Thu, 4 Jun 2026 18:09:54 +0200
From: Willy Tarreau <w@1wt.eu>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Askar Safin <safinaskar@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, netdev@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@kernel.org>, Pedro Falcato <pfalcato@suse.de>,
        Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <aiGjUqI59e966oBu@1wt.eu>
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
 <CAHk-=wifX_rrDjRGnDnOqE-usptAukuXKrmuPuVDP5bOCBWzGQ@mail.gmail.com>
 <20260601173325.GH2636677@ZenIV>
 <20260601160455.2c187574@gandalf.local.home>
 <20260601172825.a51a588ec1c32617a0e12d78@linux-foundation.org>
 <aiEb8CTM-ovMIq7-@1wt.eu>
 <CALCETrULMixRGJyGqAAujW7RN6PP2f_Orn2Y_0hpPMjRqQnY7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrULMixRGJyGqAAujW7RN6PP2f_Orn2Y_0hpPMjRqQnY7Q@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[1wt.eu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[1wt.eu:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6538-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:luto@amacapital.net,m:akpm@linux-foundation.org,m:rostedt@goodmis.org,m:viro@zeniv.linux.org.uk,m:torvalds@linux-foundation.org,m:brauner@kernel.org,m:safinaskar@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-api@vger.kernel.org,m:netdev@vger.kernel.org,m:willy@infradead.org,m:axboe@kernel.dk,m:hch@infradead.org,m:dhowells@redhat.com,m:david@kernel.org,m:pfalcato@suse.de,m:miklos@szeredi.hu,m:patches@lists.linux.dev,m:linux-fsdevel@vger.kernel.org,m:jack@suse.cz,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[w@1wt.eu,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,goodmis.org,zeniv.linux.org.uk,kernel.org,gmail.com,vger.kernel.org,kvack.org,infradead.org,kernel.dk,redhat.com,suse.de,szeredi.hu,lists.linux.dev,suse.cz];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w@1wt.eu,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[1wt.eu:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:email,1wt.eu:mid,1wt.eu:dkim,1wt.eu:from_mime,1wt.eu:email,vger.kernel.org:from_smtp,haproxy.org:url,man7.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,goodmis.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 19FB9641D0C

On Thu, Jun 04, 2026 at 08:53:15AM -0700, Andy Lutomirski wrote:
> On Wed, Jun 3, 2026 at 11:32 PM Willy Tarreau <w@1wt.eu> wrote:
> >
> > On Mon, Jun 01, 2026 at 05:28:25PM -0700, Andrew Morton wrote:
> > > On Mon, 1 Jun 2026 16:04:55 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > > On Mon, 1 Jun 2026 18:33:25 +0100
> > > > Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > >
> > > > > On Mon, Jun 01, 2026 at 10:17:23AM -0700, Linus Torvalds wrote:
> > > > >
> > > > > > TLDR: maybe we could ghet rid of "f_op->splice_read". *That* would be
> > > > > > a big simplification.
> > > > >
> > > > > FUSE might be interesting - fuse_dev_splice_read() and its ilk.
> > > > > Communications between the kernel and fuse server at least used to
> > > > > seriously want that, so that would be one place to look for unhappy
> > > > > userland...
> > > > >
> > > > > splice-related logics in fs/fuse/dev.c is interesting; another place
> > > > > like this is kernel/trace/, but I'm less familiar with that one.
> > > > >
> > > > > rostedt Cc'd (miklos already had been)
> > > >
> > > > Thanks for the Cc. The tracing ring buffer was specifically made to be used
> > > > by splice and the libtracefs has a lot of code to use it as well. As
> > > > reading the ring buffer literally swaps out the write portion with a blank
> > > > read portion, that portion (sub-buffer) is used to be directly fed into
> > > > splice, providing a zero-copy of the trace data from the write of the event
> > > > to going into a file.
> > > >
> > > > trace-cmd defaults to using splice to copy the tracing ring buffer directly
> > > > into files to avoid as much copying during live recordings as possible.
> > > >
> > > > Whatever changes we make, I would like to make sure there's no regressions
> > > > in performance of trace-cmd record.
> > >
> > > Well yes, The patchset seems sensible from a quality POV.  But to make
> > > a decision we should first have a decent understanding of its downside
> > > impact.
> > >
> > > I haven't seen a description of that impact in the discussion thus far.
> > > And that description is owed, please.
> > >
> > > I assume a small number of specialized applications are using
> > > vmsplice() to great effect?  What are those applications?  What is the
> > > impact of this change?
> >
> > > Once we are armed with that information, is there some middle ground in
> > > which we de-feature vmsplice()?  Fall back to pread/pwrite in the
> > > tricky cases and still permit vmsplicing if the application is
> > > appropriately restrictive in it usage?
> >
> > I'm using vmsplice() + tee() + splice() in high-performance applications,
> > load generators to be precise, and soon a cache. This is super convenient
> > and extremely efficient:
> >
> >   - vmsplice() is used to prepare a "master" pipe with data to be sent
> >     over TCP or kTLS
> >   - then for each request, we do tee() from this master pipe to per-request
> >     pipes.
> >   - the per-request pipes are those that are used to deliver the data to
> >     the socket via splice().
> >
> > So we effectively use vmsplice(), tee() and splice() here, and for exactly
> > the reasons they were designed: only play with page refcount and not copy
> > data. The code is here for the curious:
> >
> >    https://git.haproxy.org/?p=haproxy.git;a=blob;f=src/haterm.c
> >
> > and its ancestor is here:
> >
> >    https://github.com/wtarreau/httpterm/blob/master/httpterm.c
> >
> > It simply doubles the network bandwidth compared to not using that.
> > (62 Gbps per core vs 31). I would seriously miss it if I couldn't use
> > this anymore.
> >
> 
> Wait a moment.  This is neat, but it's literally just a benchmark,
> right?

No, it's a benchmark *tool*: it's being used to stress production code,
which is important and super hard at high loads. You place it after your
proxy and you measure the performance of the proxy (which is supposed not
to be as capable as the testing tools otherwise the methodology revolves
to testing the testing tools, which is not the point).

> I skimmed the code, and it doesn't look like a production
> workload, either.  And you manage to get around the awfulness of the
> vmsplice API's complete failure to tell you when it's done with a
> buffer by ... never actually changing the contents of the buffer.  Do
> you have any idea how you would write correct code that uses vmsplice
> for sends and then *ever* mutates the data without literally
> munmapping (or madvise or something) the data do you can safely mutate
> it?

I'm not sure what you mean here Andy. I *do not* need to change the
data, it's just a pre-made pattern.

> > I also have mid-term plans for using vmsplice() to deliver contents from
> > a cache to sockets as well via splice(). Right now our cache is split into
> > too small chunks (1kB) to make that useful, but as soon as we can move to
> > 4kB pages, it will make sense. There the same gains are expected, and I
> > would particularly dislike the idea of no longer being able to implement
> > zero-copy!
> 
> If I'm understanding you correctly, you see (and measured!) a
> performance improvement, and you would like to use it in production.

The prod for the tool is to be used to benchmark other tools. It does
the job quite well. It's even more important when you use kTLS-enabled
hardware where you can get zero-copy all along the line and delegate
the crypto to the hardware. That's the beauty of all the nice work that
was done in the stack along all these years. That code started to be
used in clear maybe 15 years ago or so, but nowadays the gains are even
more interesting.

> It seems to me that this is an excellent opportunity to remember that
> vmsplice gets a performance boost in a highly synthetic situation that
> sort of resembles a cache scenario and then to deprecate vmsplice and
> build something better!

I've definitely been keeping vmsplice() on my radar for our cache,
and we've progressively implemented various architectural updates in
haproxy precisely for this.

> Or discover that we already have something better, perhaps :)
> 
> https://man7.org/linux/man-pages/man3/io_uring_prep_send_zc.3.html

io_uring is different. We tried it "the dirty way" in the past, by
emulating a poller, and it's not worth it this way. And in order to
do it the right way, it needs to be done totally differently, which
has impacts all over the stack. The code in the file pointed to above
is just for the httpterm testing feature, but the rest is much more
complex.

> I see that this can submit a buffer without a syscall (tee + splice is
> *two* syscalls!) and that it has directly addressed what I see as the
> really big deficiency in vmsplice: "This second notification tells the
> application that the memory associated with the send is safe to get
> reused."  If I were writing the user code, I would very much want that
> notification to be an explicit part of the API instead of making a
> wild guess as I think I would need to do with vmsplice.

I agree, for the cache it's something important (not for the load
generator). But IIRC that's something you can also check via SIOCOUTQ
which is normally sufficient for a cache's eviction system (though not
fantastic).

Willy

