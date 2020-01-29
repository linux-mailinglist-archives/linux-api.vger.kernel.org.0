Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD98014C8EE
	for <lists+linux-api@lfdr.de>; Wed, 29 Jan 2020 11:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgA2Kqw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 Jan 2020 05:46:52 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46356 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgA2Kqv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 29 Jan 2020 05:46:51 -0500
Received: by mail-lj1-f196.google.com with SMTP id x14so15527431ljd.13
        for <linux-api@vger.kernel.org>; Wed, 29 Jan 2020 02:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M2do0RgbniX1atYg9VWzRLpNfKEGIACoNc4JSMMoZc4=;
        b=hBE7RzuY7uEeZyYIkFZtbQ6s3E1Fl3wa0GTsgHtkEewQG138lcjbQkSJq4//crmmv5
         +BMJJpv1cf6FSfhcqy+yIAzbmb1rEZm8SPkMlnLnLDkIM2ANWOm8Curm0SeeIXM/SToG
         2zKW8D0I453TSQZhdRLIMecGncJc4mIycXAk/bf8tqixYRIC1umYaVBlF+dCdW/b4x91
         VioTDFQsawZ4JCwiGI2J8ksSUsUQDhe7l0V9LNkjB1YrsVToN0iYOK62AktY9vEsZKCe
         s+jgrWbArndxjdDN5Mo0n3zFbyCSu9nWRKXFfI/JjGSsi6OjGsqCfv2cWVyzm0wzfJjw
         hJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M2do0RgbniX1atYg9VWzRLpNfKEGIACoNc4JSMMoZc4=;
        b=lZWF7D4okOLDc21f4hLOvZJGNXPn8F1YRnRpDkMIk9PWMDp48YvRD884ISh4OeHQTE
         0bsSqlPEBtWaprll+Xvj2jMgTAn46152Rg9idBpK8WdNaQDQVlOB4ODD3gO6YIUhFYrs
         fp3djCOLC/S1Bq8p7rmkAy5Hq4K+0HGMqTSBmW8rcw8UyprUKMlbioui1AzMtI7R5XJo
         8Shpi9WbZ1Fah5Havq2RXLJLIMQrX1lgSBwP+Q7zR90vunh7wl7LdTQ165atrwDd54Nb
         MiMeLzB0ck+CLpoU+dObBQOWTgsgwsXRG4F1uY2nXczCZkhra0z1+uQvm9a/Hsp3jlh3
         2Jgg==
X-Gm-Message-State: APjAAAV9tzz61XpfZqlTQfVza4pfQ7mfuvAlB9TNAHuypbll4c4ipYMN
        c8Jv3f7+dqAqlC5VvuNlZ4mo0g==
X-Google-Smtp-Source: APXvYqwGtucSvMzz57pxhsRPhvlF+l9vk6oanizkK1sgmspT6lJkLK9HpVY+p2IrTexNFgjGJ8+ExQ==
X-Received: by 2002:a2e:9284:: with SMTP id d4mr15459076ljh.226.1580294809568;
        Wed, 29 Jan 2020 02:46:49 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id d4sm873654lfn.42.2020.01.29.02.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 02:46:48 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id C5FD1100AFE; Wed, 29 Jan 2020 13:46:55 +0300 (+03)
Date:   Wed, 29 Jan 2020 13:46:55 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>, Jesse Barnes <jsbarnes@google.com>
Subject: Re: [PATCH v2] mm: Add MREMAP_DONTUNMAP to mremap().
Message-ID: <20200129104655.egvpavc2tzozlbqe@box>
References: <20200123014627.71720-1-bgeffon@google.com>
 <20200124190625.257659-1-bgeffon@google.com>
 <20200126220650.i4lwljpvohpgvsi2@box>
 <CADyq12xCK_3MhGi88Am5P6DVZvrW8vqtyJMHO0zjNhvhYegm1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyq12xCK_3MhGi88Am5P6DVZvrW8vqtyJMHO0zjNhvhYegm1w@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jan 27, 2020 at 05:35:40PM -0800, Brian Geffon wrote:
> Hi Kirill,
> Thanks for taking the time to look at this. I'll update the wording to
> make it clear that MREMAP_FIXED is required with MREMAP_DONTUNMAP.

I still think that chaining flags is strange. The new flag requires all
existing.

And based on the use case you probably don't really need 'fixed'
semantics all the time. The user should be fine with moving the mapping
*somewhere*, not neccessary to the given address.

BTW, name of the flag is confusing. My initial reaction was that it is
variant of MREMAP_FIXED that does't anything at the target address.
Like MAP_FIXED vs. MAP_FIXED_NOREPLACE.

Any better options for the flag name? (I have none)

> Regarding rmap, you're completely right I'm going to roll a new patch
> which will call unlink_anon_vmas() to make sure the rmap is correct,
> I'll also explicitly check that the vma is anonymous and not shared
> returning EINVAL if not, how does that sound?

Fine, I guess. But let me see the end result.

-- 
 Kirill A. Shutemov
