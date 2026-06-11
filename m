Return-Path: <linux-api+bounces-6600-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ic6cI/wEK2qD1QMAu9opvQ
	(envelope-from <linux-api+bounces-6600-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 11 Jun 2026 20:57:00 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 209E86749C8
	for <lists+linux-api@lfdr.de>; Thu, 11 Jun 2026 20:57:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=johnericson.me header.s=fm3 header.b="lqoDUw/k";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="S xhnnWM";
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6600-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6600-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=johnericson.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0C423204673
	for <lists+linux-api@lfdr.de>; Thu, 11 Jun 2026 18:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A07342B733;
	Thu, 11 Jun 2026 18:55:32 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF53638333B;
	Thu, 11 Jun 2026 18:55:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781204131; cv=none; b=NYPArHM7xJjC3wZ5DeoZdKc7KCnOZu2WYdQ9fEqdTIN1NRYYqIwcShxO6EQlKRg5WSVs5dTjzdXfGYmK9f/08ZjWrB+BVY0ASDYe2dqeGDbCeEbcWyMy7Rlw5FradKUWsQ9lJWBmg+rB/Xigojx8GCwFx86G9Wj2oBrnaQzm9Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781204131; c=relaxed/simple;
	bh=hPOHqYG+iRF3Ic0VkRMBbLpS+z9IKrHddDy3pi2hdIc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oyLWxKrD8K3xv2yOeJcMIQzsqZZtGfak581TXN5XCmX8y05DmfX0DDOb09WBbrOZxRJ2WFufJ6cj7XUom3BLhTz9zSjHGUf20hledZqs2nhN056p4a9DyNszzMsEaBWaCVKIae01iXo05DYRAcPwAVOn6yoHkFSIGn7ltehsdcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me; spf=pass smtp.mailfrom=johnericson.me; dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b=lqoDUw/k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SxhnnWMs; arc=none smtp.client-ip=103.168.172.141
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 1652F1380100;
	Thu, 11 Jun 2026 14:55:29 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-05.internal (MEProxy); Thu, 11 Jun 2026 14:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnericson.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1781204129; x=1781211329; bh=hPOHqYG+iRF3Ic0VkRMBbLpS+z9IKrHd
	dDy3pi2hdIc=; b=lqoDUw/kVA743bATY9h3WK1dphY3DTGWmWqfS7rSB5GSVn1J
	as9WBsb+A9PKES5gRpl1K43ImpkJByEQ+OAGA8jgvTajebY1O93d+Ltmq8xdbZmr
	UpjrbAZH15xpPstw++7hFOY+AQmRLZsb2gRNFyC6VpRAlni/E62ZfUjR+2Y7ilDV
	5dalJkSjuO6iJHSs2PFitbvp8GbWY+Y4zFxsBDVzhzH13FnV4hN4gX3XoXsGEpU5
	VX6YHz30fcubjL8dS4nRv3IXpnfilOnuPUp8p3r0TTr6X+SeYW3CB5Ye/Y8JCFpK
	jE+5fg0CFoxi4Y/BBElq4gToBlMwJqp/uqu9MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781204129; x=
	1781211329; bh=hPOHqYG+iRF3Ic0VkRMBbLpS+z9IKrHddDy3pi2hdIc=; b=S
	xhnnWMsEUraepm0he9orZCyxPfx/X2RF4T9x70S85+8jra4FIRU9EW5non7HfVsM
	Ci2TSpRE8DCnorJZZDCFAJnPbE74cU40UqUFdxQG06Ca0gf4YOU1CcSzAl7STslr
	hkiKH7TApmoVk+z9PZs+yoayKHgiTZtULPsVqW6Rrfak38XDnPycDho5FKzQBef1
	CY6QNcMEThwJpZ3k8dCfdqYEOgLqhPFyaSw/8plKCDA4ADs1atRjXiHektoDVGfc
	fFn8T2+BwlXB/s0NPeOq0qQ16jw7OASdZDZeHmvZZ39x54Pz2OrB2tDyBB1+NgYc
	5/H2msE/XBzMbGzzvKNHA==
X-ME-Sender: <xms:oAQralqwuh0eouA59R3_QIwyLFBttjzOXYhOIDERLdIbdk93hF5puA>
    <xme:oAQraifGdN2-ZAHIe6oNEDRfSEnR6WUhOwyGtPPn4ubpqD8tEdnDMeWgLTUy6Ii6x
    5vzuFyYmFZ2RIu87ORhcAz6vnLAsYx-tpUTNEZVfRt127tc0NsvnK0>
X-ME-Proxy-Cause: dmFkZTFYpPOn7LI4ucgrxMRuvUt0Pp7TpsmWzC1UMf5Uv3HNtfQ/V0DF7oE2QhImNcQ7/n
    hX3+SBSdsUULValjF705kUffDlbULeLEuQLe9sEh2MjAhjTTmycdP5MBvhnGe8dzZvyNon
    El9MmMNYiTmjnLQ2tcVKntlKTVipyiBsZrqxOGT4HbGXTm+q5nJv2ou/btyVBYEM9hCWwC
    5GGP97dtjAoQTfqjBznaZdB0rggqqROmubcwr/kzdeAmz621tqJGsS7RdmLEwmGJYTNNOO
    USKMjLfMmFc65L14V1RzajGF3g6WHSe5i+BYmpu3hA0CfgzgP+VZ8oTuBT+38JRx/yxzgs
    umnpTqvcNAd1NFNCHjofpW8OHDuMUHWjxpEVBjSNmRctxv64ki/DUB9+G7ogl7t9K3QVjK
    Ow2Y0fYcjWb7JTEpo/PoDYWzEvTk9XEek3xh+BpzUH00rvEY2PWP7ywJRQTdPoMcVAn7Gn
    r7cDKLJ65+s64x2Q942+XWGD/zOI1+7LvCGFjOH2uWfyZd0Fv7Ymr+gzCBsMoAv2xkL3T0
    CqD6YGWIlZSwWzrToYEFEdrCnD2xjZeUFFAtwMMKqgh8H1xdIFhWYk77oCQivDvMMOaL+9
    Tq0tCHKmG0ElxEfp2Q75UzEXsV7cS5F72NZyHP1i3LMypy67FGfWMnYliP7A
X-ME-Proxy: <xmx:oAQraroOprWSkLgJ-7djeMHTInI52a640Gjt5LslcKa87iD22lOadQ>
    <xmx:oAQraoatsZC0BtBctCPgAsy7fxQT3f9fqffQoMXyvPniBkKKuuh1bA>
    <xmx:oAQralHhcfx828vfIPwoTAB7RPq0-Rlkt4Jh2VvoK2hJ4cYJKq3hrQ>
    <xmx:oAQramZmlr4zGPtWbXjA0WPzKylSB7mfQzF7M44bZW6o1b9B_bhaGA>
    <xmx:oQQrarNSduaBJQ-qynqxxgQ-ZwyRh49OZambtOBojf-3vpyXdpA0tC_O>
Feedback-ID: ieb4144f1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0C7D62CC0086; Thu, 11 Jun 2026 14:55:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AtGJywdvvpER
Date: Thu, 11 Jun 2026 14:53:10 -0400
From: "John Ericson" <mail@johnericson.me>
To: "Mateusz Guzik" <mjguzik@gmail.com>, "Li Chen" <me@linux.beauty>
Cc: "Andy Lutomirski" <luto@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>, "Kees Cook" <kees@kernel.org>,
 "Al Viro" <viro@zeniv.linux.org.uk>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-api <linux-api@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>,
 linux-doc <linux-doc@vger.kernel.org>,
 linux-kselftest <linux-kselftest@vger.kernel.org>, x86 <x86@kernel.org>,
 "Arnd Bergmann" <arnd@arndb.de>, "Thomas Gleixner" <tglx@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Jan Kara" <jack@suse.cz>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>
Message-Id: <9033ff42-9ee7-4b93-9570-a5adcd16e826@app.fastmail.com>
In-Reply-To: 
 <hd3i6pxxohsjesyid7nhuic6ppp6nyoxxpwa4mny6riqvpyqec@mylfprni2yaw>
References: <20260528095235.2491226-1-me@linux.beauty>
 <20260528-madig-fachrichtung-fehlinformation-61117ba640da@brauner>
 <CALCETrWJQpLR4n1cpichBk8=uExSKLWTMGU3BufGdk_WE_p5UA@mail.gmail.com>
 <19eacd64508.26b92c022125848.262962729296162879@linux.beauty>
 <4e049396-377d-48a7-a34c-91318413a876@app.fastmail.com>
 <19eb181fdd4.6d028f442844776.3737831021032223216@linux.beauty>
 <hd3i6pxxohsjesyid7nhuic6ppp6nyoxxpwa4mny6riqvpyqec@mylfprni2yaw>
Subject: Re: [RFC PATCH v1 00/13] exec: add spawn templates for repeated executable
 startup
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[johnericson.me,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[johnericson.me:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mjguzik@gmail.com,m:me@linux.beauty,m:luto@kernel.org,m:brauner@kernel.org,m:kees@kernel.org,m:viro@zeniv.linux.org.uk,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-arch@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:x86@kernel.org,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mail@johnericson.me,linux-api@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,linux.beauty];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6600-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@johnericson.me,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[johnericson.me:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,johnericson.me:dkim,johnericson.me:from_mime,vger.kernel.org:from_smtp,app.fastmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 209E86749C8

On Wed, Jun 10, 2026, at 7:40 PM, Mateusz Guzik wrote:
> [...]
>
> As I tried to explain in my previous e-mail this approach does not cut
> it because of NUMA.
>
> Suppose you have a machine with 2 nodes. The parent-to-be is running
> on node 0 and the child is intended to exec something on node 1.
>
> When the parent-to-be allocates and populates stuff, it takes place with
> memory backed by node 0. If you allocate task_struct, the file table and
> other frequently used (and modified!) objs in this way, you are
> guaranteeing performance loss due to interconnect traffic to access it.
>
> Trying to add plumbing so that all allocations respect numa placement is
> probably too cumbersome.

Are we sure that last part is true?

Let's also assume when this stuff was initially implemented, we didn't
have it. If the basic thrust of this work is to replace functions that
previously only worked on the current thread with those that worked on
either arbitrary (not yet started) threads or the current thread, would
that not prepare us for slowly migrating the allocation choice to
reflect the node of the target task (new parameter) rather than the node
of the current task over time?

(This assumes the task is pre-placed on a node before it is actually run
there, and that pre-placement happens as early in the allocation process
as possible, so subsequent allocations can read off the
partially-initialized task's node.)

"Slowly migrating" is good here! It doesn't need to be the fastest thing
out of the gate, but if this new proper spawning API gets popular as I
think it would, and there is a clear path to optimizing it per the
above, then I am confident that over the years it will happen.

> The primary example for that is looking up the binary to exec in the
> first place.
>
> userspace likes to pass paths which don't exist, meaning checking for
> the binary before any hard work is a useful optimization. Suppose the
> binary to be executed is in a container bound with a taskset using
> node 1 and the content of the fs part of the container is currently
> fully uncached.
>
> When you perform the lookup on node 0, you are populating a bunch of
> metadata (inode, dentry) using memory from that domain. But the intended
> user will only execute on node 1, again resulting in a performance loss.
>
> In order to not do it you would need to convince VFS to allocate memory
> elsewhere.

One thing I don't get about this is that isn't the cost doing a bunch of
work searching the PATH for the directories where the executable
*doesn't* exist? In the case of something like a shell that is going to
spawn a lot of processes, I would think it is *good* to keep all that
PATH crawling VFS filling to be on the shell's node, rather than the
child processes' nodes.

It is only the executable itself, the final step of the VFS crawl, that
should be loaded into the other NUMA nodes. Insofar as (unless I am
missing something) creating the process means finding the inode for the
executable but not loading those pages, aren't we OK here? Only when the
new process is actually scheduled and run must the ELF be paged into
memory, and then that will happen on the correct node.

> So I stand by my previous claim that ultimately a pristine child has to
> be created (like in this patch), but which also has to do the work on
> its own.

I have not been a kernel dev, so my apologies if I am missing things.
But in conclusion for me, the FS and other resource access patterns of
*creating a process* vs *that process itself running* do not seem
necessarily coincident to me. What you are describing as for sure a
problem might possibly be a *good thing*, if they are in fact quite
different.

> Suppose there is no explicit placement requested anywhere. Even in that
> case there are legitimate workloads which will eventually be forced to
> exec stuff on another node. Even these have a better chance retaining
> full locality if the child process does all the work.
>
> Per my previous message I don't see a clean interface to do it.
> something quasi-posix_spawn is probably the least bad way out, it will
> also allow userspace to easily wrap the new thing with posix_spawn
> itself.
>
> Also note there is another issue with the fd-based approach: the fd will
> get inherited on fork and will hang out in the child afterwards unless
> explicitly closed. Suppose you have a multithreaded program which likes
> to both fork(+no exec) and fork+exec. With the fd-based approach you
> have no means of stopping another thread from grabbing your state thanks
> to unix defaulting to copying everything. There was an attempt to fix
> this aspect with O_CLOFORK, but this got rejected.

I would think we don't need to worry about clone/fork very much, right?
I think the premise of your emails, and just about everyone else's in
this thread too, is that we agree fork+exec is bad, and the problem of
unnecessarily sharing resources is inherent to fork. Furthermore, I
think we all agree that while `O_CLOEXEC` and `O_CLOFORK` may help, both
are unsatisfying solutions because they are opt-out not opt-in, and
global to the parent process / preexec state (respectively) rather than
local to the specific fork / exec in question.

pidfds encounter these problems no more than any other
file-descriptor-based UAPI, right? And I don't think it is good to blame
any such file-descriptor-based UAPI when fork/exec are at fault.

Maybe during the transition, when some things use fork and some things
use this new API, stuff will be awkward, but I would rather that just be
an incentive to complete the transition away from fork, not a reason to
second-guess the plan.

Once the transition is complete, and everyone is diligently assembling
their child processes from scratch as is proposed, `O_CLOEXEC` and
`O_CLOFORK` are both unneeded, and oversharing privileges will be much
less common simply because "lazy coding"/"minimal typing" will only
share what is needed --- anything else is more code/keystrokes!

> Whatever exactly happens, NUMA is a sad fact of computing and needs to
> be accounted for. The approach as proposed not only does not do it, but
> it actively hinders such deployments.

Despite everything I said, I want to be clear that I do agree that NUMA
performance should be accounted for. Even if the first version isn't as
great as it could be on that metric, there should be a clear plan for
how future work can conclusively address it.

Cheers,

John

