Return-Path: <linux-api+bounces-767-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA886843624
	for <lists+linux-api@lfdr.de>; Wed, 31 Jan 2024 06:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33FA283F9F
	for <lists+linux-api@lfdr.de>; Wed, 31 Jan 2024 05:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0C23D982;
	Wed, 31 Jan 2024 05:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+T03nDw"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126B83D571;
	Wed, 31 Jan 2024 05:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706679753; cv=none; b=HOg0+5TIClx+XMTQhnhmaD5x/VZT8PnoCIYjGRCbDN7b/0KX21EwZkt7x9XlR2pcsmuQvB4muG9Gu/L6+8QKM0idAUv7/S/NdNkYE0u/MZ8p3av4UBbC/m58GsmxvrlwerMJmd8igu/UC9QMbJVexc7qqvLbCcxvwwYWtVIv65M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706679753; c=relaxed/simple;
	bh=xWObP8eJtgSIeh4UqSV//F4g7UxekurChddfhz3MPaY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lY2sm5YYCoM7fX6tQFQzCdiJDDlvhYEIcbTpSbgqHILTli51ownh7gmY8xooHgaff6uApiXXsmpPZvxPZIy4F+3g/8NTikUFGTTehlaVKvddCdIFBmP+508SplN5CWbxR/Fw1PmYp39soIF3f41i72hH0fW7Ud+0FXss1gkOx74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+T03nDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90A5C433C7;
	Wed, 31 Jan 2024 05:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706679752;
	bh=xWObP8eJtgSIeh4UqSV//F4g7UxekurChddfhz3MPaY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I+T03nDwI8FINU4rgLtUVPMCMl8Nj5ePEewOGGUQbnPSdBqp5xS4YeSZjOFu4jXqD
	 WxaMcIg7F/S9+huG4NIUUnxmCPcQOZi6UPX3LEbOs+HG9la7AEUCWyOQY0AYaflUuh
	 mX1WjD/ZVRdLjkpp5ACRnR55fxAhjo+Z9H0l1WgBRxB8Rche1youy6os2BFYszbqTO
	 pTdw3BqRzUBWfO96r10KtJy4Tbk8c86fJCCqy5eKm+jcBX9IkSd1JGp5gmZy/6vSy8
	 CQnfyqYKKyJt+KixMf1y0TcNeXNR6WcNqjX33/NCRrupp73CskMAozOljFIxG4A9D5
	 g59YuNw93/rmA==
Date: Wed, 31 Jan 2024 06:42:24 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, linux-doc@vger.kernel.org,
 linux-api@vger.kernel.org
Subject: Re: [PATCH 4/5] Documentation/ABI/README: convert to ReST
Message-ID: <20240131064224.2b7d946d@coco.lan>
In-Reply-To: <c77c1875-5e32-491a-8abf-502ebe371eb5@oracle.com>
References: <20240104160946.3450743-1-vegard.nossum@oracle.com>
	<20240104160946.3450743-4-vegard.nossum@oracle.com>
	<20240105210739.20ae5f05@coco.lan>
	<c77c1875-5e32-491a-8abf-502ebe371eb5@oracle.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 8 Jan 2024 14:18:55 +0100
Vegard Nossum <vegard.nossum@oracle.com> escreveu:

> On 05/01/2024 21:07, Mauro Carvalho Chehab wrote:
> > Em Thu,  4 Jan 2024 17:09:45 +0100
> > Vegard Nossum <vegard.nossum@oracle.com> escreveu:  
> >> +Every file in these directories will contain the following information::
> >> +
> >> + What:		Short description of the interface
> >> + Date:		Date created
> >> + KernelVersion:	Kernel version this feature first showed up in.
> >> + Contact:	Primary contact for this interface (may be a mailing list)
> >> + Description:	Long description of the interface and how to use it.
> >> + Users:		All users of this interface who wish to be notified when
> >> + 		it changes.  This is very important for interfaces in
> >> + 		the "testing" stage, so that kernel developers can work
> >> + 		with userspace developers to ensure that things do not
> >> + 		break in ways that are unacceptable.  It is also
> >> + 		important to get feedback for these interfaces to make
> >> + 		sure they are working in a proper way and do not need to
> >> + 		be changed further.  
> > 
> > My personal preference would be to use:
> > 
> > :What:
> > 
> > as this produces a better markup.  
> 
> I would prefer to alter this as little as possible, since it describes
> the literal format of those ABI files, keeping it readable and
> understandable in plain text as well as HTML -- with a single leading
> space this whole block shows up as a code block in the HTML, which I
> think is appropriate when giving an example of a literal file.

Well, you're still not being strict by adding a single space after
the field. That's OK for ReST, but if one uses it as a template, the
extra space will cause problems.

Btw, in the specific case of this code block, there is one alternative
approach: keep it untouched and create a new ReST file on a similar
approach to what it was done at Documentation/core-api/wrappers/, e. g.:

.. SPDX-License-Identifier: GPL-2.0
   This is a simple wrapper to bring ABI/README into the RST world.

<snip>
===============================
Linux userspace ABI description
===============================

.. raw:: latex

    \footnotesize

.. include:: ../../ABI/README
   :literal:

.. raw:: latex

    \normalsize
</snip>


While I don't like very much this approach, in this very specific
case, it is justified, at least for the field description.

(Note: the latex part to change the font size may not be needed - it will
depend on how this file will appear at the pdf version)

> >> diff --git a/Documentation/process/submit-checklist.rst b/Documentation/process/submit-checklist.rst
> >> index b1bc2d37bd0a..7e6198ab368d 100644
> >> --- a/Documentation/process/submit-checklist.rst
> >> +++ b/Documentation/process/submit-checklist.rst
> >> @@ -85,7 +85,7 @@ and elsewhere regarding submitting Linux kernel patches.
> >>   17) All new module parameters are documented with ``MODULE_PARM_DESC()``
> >>   
> >>   18) All new userspace interfaces are documented in ``Documentation/ABI/``.
> >> -    See ``Documentation/ABI/README`` for more information.
> >> +    See ``Documentation/ABI/README.rst`` for more information.  
> > 
> > If you're willing to convert to ReST, please remove ``, as this will
> > let automarkup.py to create cross-reference links. Same note for the
> > translations too.  
> 
> Good point -- Jon, do you want me to resubmit this or can you fix it up?
> 
> We could also just run a "treewide" fix for this as a separate patch:
> 
>      git grep -l '``Documentation/.*\.rst``' 'Documentation/**.rst' \
>          | xargs sed -i 's|``\(Documentation[^`*]*\.rst\)``|\1|g'

Doing it globally won't work, as there are a few cases where `` is needed: 

- when there are wildcards at the file name, like:

	Documentation/driver-api/usb/power-management.rst:covered to some extent (see ``Documentation/power/*.rst`` for more

- when they don't point to the actual docs, like:

	Documentation/doc-guide/sphinx.rst:documentation is under ``Documentation/gpu``, split to several ``.rst`` files,

- on some cases, it may require a different approach, or may not
  make sense, like here:

	Documentation/doc-guide/sphinx.rst:2. Refer to it from the Sphinx main `TOC tree`_ in ``Documentation/index.rst``.

  (the `Toc tree`_ is already an cross-reference link. So, it OK to keep
   ``Documentation/index.rst`` to help people reading at the sources)

- when it points, for instance, to ./tools/*/Documentation, as those
  are currently outside the scope of the ReST docs. Not sure if we
  still have this at the docs


Thanks,
Mauro

