Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7F6200BD
	for <lists+linux-api@lfdr.de>; Thu, 16 May 2019 09:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfEPH6f (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 May 2019 03:58:35 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:33537 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726363AbfEPH6f (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 May 2019 03:58:35 -0400
X-Greylist: delayed 319 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 May 2019 03:58:34 EDT
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 16A5814BEB;
        Thu, 16 May 2019 03:53:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 16 May 2019 03:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=He5ihOaVJM+Plo3d4jGHJxUuKm1
        xliYsYWOaqQ0envA=; b=TuDI+0XFE8t8180O3v+rB58RTJJ3y43gJzRwdtVSU+4
        Dv+4pTsoYrcWduUmrj/Mq618J6KdZTLc8PDFG74rWo2ihvZucwqc84MkrG/5KvUt
        TdQnDjb7DAg53CkG0VPLBN0HpnsprYu21jAeVjR8WYRopj7nAZ/fMptg1lJBkKj+
        zJiVHbZezd6qLHcYjEnpAui/B0IrLJnvMaX5XG5VO5Be9b++zeSTjBhzF4inNHJx
        F0MzY7cqduS+LJYYYWnOHu5oIu9o1qqUaOE+M6KGjy78WACFJQMNVwBJx7gmoWFm
        AgZiDmmCfKr7maEI201M4+xrJPHHVIqhkG67mrVT+xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=He5ihO
        aVJM+Plo3d4jGHJxUuKm1xliYsYWOaqQ0envA=; b=4+Ynej1giCxUUBh4tXh420
        pk/bhKQc4kwIzH4pQ4qTOec7EDLUs35E4Y3dU326T+yZ6PPt4GoVyC1VWf41HWFp
        9lVblB6hWxeCuHaZxShsKlBsxjnebfk2akCSYYRMiqAt0/KBR0XBw/H4tWQ/Bw/7
        hkNzxbnD1tysh5l0sAXjwHvlVM5uHnEd0WtNLz6NarGNP+lB0yXk9uTEH4IgFjve
        RsOhLJm3Vz/n+8Zqh2kAnEoRvHUqb8P/Sq8edJyXZuyTS+XjmTseL8bBs8uwICA0
        mltj4yaACtRMn1C+6aoXTsdav5ejNAIVCYBbcQ9QnmY9Kr4X2nF8eWewKmOkWq2A
        ==
X-ME-Sender: <xms:6RbdXDxElR21kae1GMvxGoXJi2kfqW86-h7-eLBPjszQ4owQS5elXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleelgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledrud
    dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:6RbdXPjqUESiA4ZSSxnQHhhETt9GvPLPAY2D-qyJkgsURjtHOrPP4g>
    <xmx:6RbdXIXI2TcxkepwHpJIWqUltwr3l8uPCIuO861Yq5wTexXJBU-12g>
    <xmx:6RbdXB3ofLEidx_oWgxWqY7wQ3Rg5LARy5kc4BD4RMKweWx0JtRmdQ>
    <xmx:6xbdXKgpagGTezi2xrJu5uBe_HS7U8KmvpVZWjZ1ld_s4PKEPF3iGw>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4F31B103CC;
        Thu, 16 May 2019 03:53:13 -0400 (EDT)
Date:   Thu, 16 May 2019 09:53:11 +0200
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
Message-ID: <20190516075311.GA10467@kroah.com>
References: <20190514131654.25463-1-oleksandr@redhat.com>
 <20190514144105.GF4683@dhcp22.suse.cz>
 <20190514145122.GG4683@dhcp22.suse.cz>
 <20190515062523.5ndf7obzfgugilfs@butterfly.localdomain>
 <20190515065311.GB16651@dhcp22.suse.cz>
 <20190515145151.GG16651@dhcp22.suse.cz>
 <20190515151557.GA23969@kroah.com>
 <20190516074713.GK16651@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516074713.GK16651@dhcp22.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 16, 2019 at 09:47:13AM +0200, Michal Hocko wrote:
> On Wed 15-05-19 17:15:57, Greg KH wrote:
> > On Wed, May 15, 2019 at 04:51:51PM +0200, Michal Hocko wrote:
> > > [Cc Suren and Minchan - the email thread starts here 20190514131654.25463-1-oleksandr@redhat.com]
> > > 
> > > On Wed 15-05-19 08:53:11, Michal Hocko wrote:
> > > [...]
> > > > I will try to comment on the interface itself later. But I have to say
> > > > that I am not impressed. Abusing sysfs for per process features is quite
> > > > gross to be honest.
> > > 
> > > I have already commented on this in other email. I consider sysfs an
> > > unsuitable interface for per-process API.
> > 
> > Wait, what?  A new sysfs file/directory per process?  That's crazy, no
> > one must have benchmarked it :)
> 
> Just to clarify, that was not a per process file but rather per process API.
> Essentially echo $PID > $SYSFS_SPECIAL_FILE

Ick, no, that's not ok either.  sysfs files are not a replacement for
syscalls :)

thanks,

greg k-h
