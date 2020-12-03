Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DD72CE281
	for <lists+linux-api@lfdr.de>; Fri,  4 Dec 2020 00:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgLCXRj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Thu, 3 Dec 2020 18:17:39 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:48128 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726721AbgLCXRj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 Dec 2020 18:17:39 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-74-ZN_hijpIMCiOzkEhiip_Rg-1; Thu, 03 Dec 2020 23:16:00 +0000
X-MC-Unique: ZN_hijpIMCiOzkEhiip_Rg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 3 Dec 2020 23:15:59 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 3 Dec 2020 23:15:59 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mike Rapoport' <rppt@kernel.org>,
        Topi Miettinen <toiwoton@gmail.com>
CC:     "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: RE: [PATCH] mm/vmalloc: randomize vmalloc() allocations
Thread-Topic: [PATCH] mm/vmalloc: randomize vmalloc() allocations
Thread-Index: AQHWyUIaOaq71c1O10ObeOeJDE6bhanmALEg
Date:   Thu, 3 Dec 2020 23:15:59 +0000
Message-ID: <2a672ff3df0c47538ed7d1974c864f0b@AcuMS.aculab.com>
References: <20201201214547.9721-1-toiwoton@gmail.com>
 <9d34fb0a-7aba-1e84-6426-006ea7c3d9f5@gmail.com>
 <20201203065801.GH751215@kernel.org>
In-Reply-To: <20201203065801.GH751215@kernel.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Mike Rapoport
> Sent: 03 December 2020 06:58
> 
> On Wed, Dec 02, 2020 at 08:49:06PM +0200, Topi Miettinen wrote:
> > On 1.12.2020 23.45, Topi Miettinen wrote:
> > > Memory mappings inside kernel allocated with vmalloc() are in
> > > predictable order and packed tightly toward the low addresses. With
> > > new kernel boot parameter 'randomize_vmalloc=1', the entire area is
> > > used randomly to make the allocations less predictable and harder to
> > > guess for attackers.

Isn't that going to horribly fragment the available address space
and make even moderate sized allocation requests fail (or sleep).

I'm not even sure that you need to use 'best fit' rather than
'first fit'.
'best fit' is certainly a lot better for a simple linked list
user space malloc.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

