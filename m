Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3769B77FFB
	for <lists+linux-api@lfdr.de>; Sun, 28 Jul 2019 17:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfG1PIZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 28 Jul 2019 11:08:25 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55587 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726032AbfG1PIY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 28 Jul 2019 11:08:24 -0400
Received: from callcc.thunk.org (96-72-102-169-static.hfc.comcastbusiness.net [96.72.102.169] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x6SF835t026387
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Jul 2019 11:08:04 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 34FB54202F5; Sun, 28 Jul 2019 11:08:02 -0400 (EDT)
Date:   Sun, 28 Jul 2019 11:08:02 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-api@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v7 01/16] fs, fscrypt: move uapi definitions to new
 header <linux/fscrypt.h>
Message-ID: <20190728150802.GA6088@mit.edu>
References: <20190726224141.14044-1-ebiggers@kernel.org>
 <20190726224141.14044-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726224141.14044-2-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 26, 2019 at 03:41:26PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> More fscrypt definitions are being added, and we shouldn't use a
> disproportionate amount of space in <linux/fs.h> for fscrypt stuff.
> So move the fscrypt definitions to a new header <linux/fscrypt.h>.
> 
> For source compatibility with existing userspace programs, <linux/fs.h>
> still includes the new header.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good, feel free to add:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

