Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35B00565E6
	for <lists+linux-api@lfdr.de>; Wed, 26 Jun 2019 11:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfFZJtQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Wed, 26 Jun 2019 05:49:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41238 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfFZJtQ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 26 Jun 2019 05:49:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 34C0D3082E06;
        Wed, 26 Jun 2019 09:49:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A6AD5D9C6;
        Wed, 26 Jun 2019 09:49:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190625082822.l4pz33dwzvotboe4@brauner.io>
References: <20190625082822.l4pz33dwzvotboe4@brauner.io> <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk> <156138533403.25627.4606280739806094239.stgit@warthog.procyon.org.uk>
To:     Christian Brauner <christian@brauner.io>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, raven@themaw.net,
        mszeredi@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/25] vfs: syscall: Add fsinfo() to query filesystem information [ver #14]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7559.1561542552.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Wed, 26 Jun 2019 10:49:12 +0100
Message-ID: <7560.1561542552@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 26 Jun 2019 09:49:15 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Christian Brauner <christian@brauner.io> wrote:

> > +	return sizeof(*p);
> 
> Hm, the discrepancy between the function signature returning int and
> the sizeof operator most likely being size_t is bothering me. It
> probably doesn't matter but maybe we can avoid that.

If sizeof(*p) exceeds 4096, the buffer is going to have been overrun by this
point anyway.

The function can't return size_t, though it could return ssize_t.  I could
switch it to return long or even store the result in fsinfo_kparams::usage and
return 0.

> > +	strlcpy(p->f_fs_name, path->dentry->d_sb->s_type->name,
> > +		sizeof(p->f_fs_name));
> 
> Truncation is acceptable or impossible I assume?

I'm hoping that file_system_type::name isn't going to exceed 15 chars plus
NUL.  If it does, it will be truncated.  I don't really want to add an
individual attribute just for the filesystem driver name.

> > +#define _gen(X, Y) FSINFO_ATTR_##X: return fsinfo_generic_##Y(path, params->buffer)
> 
> I'm really not sure that this helps readability in the switch below... :)
> 
> > +
> > +	switch (params->request) {
> > +	case _gen(STATFS,		statfs);
> > +	case _gen(IDS,			ids);
> > +	case _gen(LIMITS,		limits);
> > +	case _gen(SUPPORTS,		supports);
> > +	case _gen(CAPABILITIES,		capabilities);
> > +	case _gen(TIMESTAMP_INFO,	timestamp_info);
> > ...

I'm trying to avoid having to spend multiple lines per case and tabulation
makes things easier to read.  So

	case FSINFO_ATTR_SUPPORTS:		return fsinfo_generic_supports(path, params->buffer);
	case FSINFO_ATTR_CAPABILITIES:		return fsinfo_generic_capabilities(path, params->buffer);
	case FSINFO_ATTR_TIMESTAMP_INFO:	return fsinfo_generic_timestamp_info(path, params->buffer);

is a bit on the long side per line, whereas:

	case FSINFO_ATTR_SUPPORTS:
		return fsinfo_generic_supports(path, params->buffer);
	case FSINFO_ATTR_CAPABILITIES:
		return fsinfo_generic_capabilities(path, params->buffer);
	case FSINFO_ATTR_TIMESTAMP_INFO:
		return fsinfo_generic_timestamp_info(path, params->buffer);

is less readable by interleaving two of the three columns.  (Note that _gen is
a actually third column as I introduce alternatives later).

> > +		if (ret <= (int)params->buf_size)
> 
> He, and this is where the return value discrepancy hits again. Just
> doesn't look nice tbh. :)

No.  That's dealing with signed/unsigned comparison.  It might be better if I
change this to:

		if (IS_ERR_VALUE(ret))
			return ret; /* Error */
		if ((unsigned int)ret <= params->buf_size)
			return ret; /* It fitted */

In any case, buf_size isn't permitted to be larger than INT_MAX due to a check
later in the loop.

> > +		kvfree(params->buffer);
> 
> That means callers should always memset fsinfo_kparams or this is an
> invalid free...

vfs_info() isn't a public function.  And, in any case, the caller *must*
provide a buffer here.

> > + * Return buffer information by requestable attribute.
> > + *
> > + * STRUCT indicates a fixed-size structure with only one instance.
> > ...
> I honestly have a hard time following the documentation here

How about:

 * STRUCT	- a fixed-size structure with only one instance.
 * STRUCT_N	- a sequence of STRUCTs, indexed by Nth
 * STRUCT_NM	- a sequence of sequences of STRUCTs, indexed by Nth, Mth
 * STRING	- a string with only one instance.
 * STRING_N	- a sequence of STRING, indexed by Nth
 * STRING_NM	- a sequence of sequences of STRING, indexed by Nth, Mth
 * OPAQUE	- a blob that can be larger than 4K.
 * STRUCT_ARRAY - an array of structs that can be larger than 4K

> and that monster table/macro thing below.  For example, STRUCT_NM
> corresponds to __FSINFO_NM or what?

STRUCT_NM -> .type = __FSINFO_STRUCT, .flags = __FSINFO_NM, .size = ...

If you think this is bad, you should try looking at the device ID tables used
by the drivers and the attribute tables;-)

I could spell out the flag and type in the macro defs (such as the body of
FSINFO_STRING(X,Y) for instance).  It would make it harder to compare macros
as it wouldn't then tabulate, though.

> And is this uapi as you're using this in your samples/test below?

Not exactly.  Each attribute is defined as being a certain type in the
documentation in the UAPI header, but this is not coded there.  The assumption
being that if you're using a particular attribute, you'll know what the type
of the attribute is and you'll structure your code appropriately.

The reason the sample code has this replicated is that it doesn't really
attempt to interpret the type per se.  It has a dumper for an individual
attribute value, but the table tells it whether there should be one of those,
N of those or N of M(0), M(1), M(2), ... of those so that it can report an
error if it doesn't see what it expects.

I could even cheaply provide a meta attribute that dumps the contents of the
table (just the type info, not the names).

> > ...
> > +	FSINFO_STRING		(NAME_ENCODING,		-),
> > +	FSINFO_STRING		(NAME_CODEPAGE,		-),
> > +};
> 
> Can I complain again that this is really annoying to parse.

Apparently you can;-)  What would you prefer?  This:

static const struct fsinfo_attr_info fsinfo_buffer_info[FSINFO_ATTR__NR] = {
	[FSINFO_STATFS] = {
		.type	= __FSINFO_STRUCT,
		.size	= sizeof(struct fsinfo_statfs),
	},
	[FSINFO_SERVERS] = {
		.type	= __FSINFO_STRUCT,
		.flags	= __FSINFO_NM,
		.size	= sizeof(struct fsinfo_server),
	},
	...
};	

That has 3-5 lines for each 1 in the current code and isn't a great deal more
readable.

> if (copy_to_user()) and if (clear_user()) and not if (clear_user() != 0)

Better "if (copy_to_user() != 0)" since it's not a boolean return value in
either case.

> Nit: There's a bunch of name inconsistency for the arguments between the
> stub and the definition:
> 
> SYSCALL_DEFINE5(fsinfo,
> 		int, dfd, const char __user *, filename,
> 		struct fsinfo_params __user *, _params,
> 		void __user *, user_buffer, size_t, user_buf_size)

Yeah.  C just doesn't care.

I'll change filename to pathname throughout.  That's at least consistent with
various glibc manpages for other vfs syscalls.

_params I can change to params and params as-was to kparams.

But user_buffer and user_buf_size, I'll keep as I've named them such to avoid
confusion with kparams->buffer and kparams->scratch_buffer.  However, I
wouldn't want to call them that in the UAPI.

> Do we do SPDX that way? Or isn't this just supposed to be:
> // <spdxy stuff>

Look in, say, include/uapi/linux/stat.h or .../fs.h.

> > +	FSINFO_ATTR__NR
> 
> Nit/Bikeshed: FSINFO_ATTR_MAX? Seems more intuitive.

No.  That would imply a limit that it will never exceed.

> > +struct fsinfo_u128 {
> > +#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __BIG_ENDIAN : defined(__BIG_ENDIAN)
> > +	__u64	hi;
> > +	__u64	lo;
> > +#elif defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
> > +	__u64	lo;
> > +	__u64	hi;
> > +#endif
> > +};
> 
> Hm, I know why you do this custom fsinfo_u128 thingy but for userspace
> that is going to be annoying to operate with, e.g. comparing the
> size/space of two filesystems etc.

We don't have a __u128 in the UAPI, and I'm reluctant to use __uint128_t.

Do you have a better suggestion?

> > +struct fsinfo_ids {
> > +	char	f_fs_name[15 + 1];	/* Filesystem name */
> 
> You should probably make this a macro so userspace can use it in fs-name
> length checks too.

The name length, you mean?  Well, you can use sizeof...

> > +	FSINFO_CAP__NR
> 
> Hm, again, maybe better to use FSINFO_CAP_MAX?

It's not a limit.

David
