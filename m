Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4951F73F
	for <lists+linux-api@lfdr.de>; Wed, 15 May 2019 17:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfEOPQD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 May 2019 11:16:03 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:50775 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726567AbfEOPQD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 May 2019 11:16:03 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 09669B881;
        Wed, 15 May 2019 11:16:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 15 May 2019 11:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=vwxG4zfHU1KFopIJRohTDTKqQxn
        zS9PnCdczIsuquQE=; b=gHkvdyLXIDp0vGK+W7yRjq/rjgDBR7tzxR9R7z0JJ1t
        ETMPawT6EO98yeb7fpVVWt78adtbwr/Q37R6ICQ7ZwRkAQ8vUCi0d75RMV5sb3eO
        0xSr5dWVddZu+LzMa6uIh58y3U7HetT2sfUzDyjUzv27XnzaERYulO/VlhQQXWNd
        QuJ76pupaP85prOYolxkTr2nSaBiE97VCOL8LJl7wOggdplGlOHDeqSTYi/l5aU9
        kJtY3WWhxfjjFWVSm4/hnfcVNvvlvUJXggpjlWD4as3sUr0doQ0LcsnMbF1t2KvF
        wa1kF5teSJTxaOrkcMaK2wFnufZCFGLivbQIb5ch4DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=vwxG4z
        fHU1KFopIJRohTDTKqQxnzS9PnCdczIsuquQE=; b=gtRcPgCq3KlYjNgN5VkUbh
        vPRqtf232eMydJaBzRhgEFMZPVJPaepK61PHnjsTO+aI6xO3+7vnL/QBNCYW0npR
        mdjON24eCAjS6h/CQZbl5kSg45zXOyaWlWtJoFkhcT0qKt7ACvNcdSx8DeVfrI3V
        Fu0gV/rF7R27mDeD5OJIQgbAn+yPoLzLGeiwa+uXa/geqqpcbNl1YzklJid0l0vX
        9a34M5XrENZALRRrYViU+9A/9NK9oBeRjVzf9HCuAli4jeKE1usn5PEv6h1JSmSh
        1PYMfmNLU+/Q08L4tp1ioiGimAOCbgcjleRwUgiZZbUu3NyXTOxvsAwpWkmtpHLQ
        ==
X-ME-Sender: <xms:Ly3cXIqtEcRx9UKvtT31bHQPGHtqif2FimXrV5sg9rf5MZDW0qE-TA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleekgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:MC3cXDmYW1qVvqbi6kuOuyKLMhJdj57T6xm-YL-Bzw-5gC_7Eyls_w>
    <xmx:MC3cXIvjo27jTfAB63rKqho2w26r_LTW_30RhoeNi8vMnmwkQPw7ZQ>
    <xmx:MC3cXDDKfweBa9OM_nuhIdbZJYf_IXPTRxGZvsw3KAjiMz0KJMEQWQ>
    <xmx:MS3cXKbqACB4COtIQLCVlB1vCPAk72yRC4uF8X0KOiQ7lOfuM8BeuA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 71077103CB;
        Wed, 15 May 2019 11:15:59 -0400 (EDT)
Date:   Wed, 15 May 2019 17:15:57 +0200
From:   Greg KH <greg@kroah.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Oleksandr Natalenko <oleksandr@redhat.com>,
        linux-kernel@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH RFC v2 0/4] mm/ksm: add option to automerge VMAs
Message-ID: <20190515151557.GA23969@kroah.com>
References: <20190514131654.25463-1-oleksandr@redhat.com>
 <20190514144105.GF4683@dhcp22.suse.cz>
 <20190514145122.GG4683@dhcp22.suse.cz>
 <20190515062523.5ndf7obzfgugilfs@butterfly.localdomain>
 <20190515065311.GB16651@dhcp22.suse.cz>
 <20190515145151.GG16651@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515145151.GG16651@dhcp22.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, May 15, 2019 at 04:51:51PM +0200, Michal Hocko wrote:
> [Cc Suren and Minchan - the email thread starts here 20190514131654.25463-1-oleksandr@redhat.com]
> 
> On Wed 15-05-19 08:53:11, Michal Hocko wrote:
> [...]
> > I will try to comment on the interface itself later. But I have to say
> > that I am not impressed. Abusing sysfs for per process features is quite
> > gross to be honest.
> 
> I have already commented on this in other email. I consider sysfs an
> unsuitable interface for per-process API.

Wait, what?  A new sysfs file/directory per process?  That's crazy, no
one must have benchmarked it :)

And I agree, sysfs is not for that, please don't abuse it.  Proc is for
process apis.

thanks,

greg k-h
