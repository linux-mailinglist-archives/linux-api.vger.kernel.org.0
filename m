Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA27FD11AF
	for <lists+linux-api@lfdr.de>; Wed,  9 Oct 2019 16:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfJIOsK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Oct 2019 10:48:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:39242 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728019AbfJIOsK (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 9 Oct 2019 10:48:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D9821B188;
        Wed,  9 Oct 2019 14:48:06 +0000 (UTC)
Subject: Re: [PATCH] off-by-one in get_mempolicy(2)
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191009140559.GY26530@ZenIV.linux.org.uk>
From:   Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 mQINBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABtCBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PokCVAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJcbbyGBQkH8VTqAAoJECJPp+fMgqZkpGoP
 /1jhVihakxw1d67kFhPgjWrbzaeAYOJu7Oi79D8BL8Vr5dmNPygbpGpJaCHACWp+10KXj9yz
 fWABs01KMHnZsAIUytVsQv35DMMDzgwVmnoEIRBhisMYOQlH2bBn/dqBjtnhs7zTL4xtqEcF
 1hoUFEByMOey7gm79utTk09hQE/Zo2x0Ikk98sSIKBETDCl4mkRVRlxPFl4O/w8dSaE4eczH
 LrKezaFiZOv6S1MUKVKzHInonrCqCNbXAHIeZa3JcXCYj1wWAjOt9R3NqcWsBGjFbkgoKMGD
 usiGabetmQjXNlVzyOYdAdrbpVRNVnaL91sB2j8LRD74snKsV0Wzwt90YHxDQ5z3M75YoIdl
 byTKu3BUuqZxkQ/emEuxZ7aRJ1Zw7cKo/IVqjWaQ1SSBDbZ8FAUPpHJxLdGxPRN8Pfw8blKY
 8mvLJKoF6i9T6+EmlyzxqzOFhcc4X5ig5uQoOjTIq6zhLO+nqVZvUDd2Kz9LMOCYb516cwS/
 Enpi0TcZ5ZobtLqEaL4rupjcJG418HFQ1qxC95u5FfNki+YTmu6ZLXy+1/9BDsPuZBOKYpUm
 3HWSnCS8J5Ny4SSwfYPH/JrtberWTcCP/8BHmoSpS/3oL3RxrZRRVnPHFzQC6L1oKvIuyXYF
 rkybPXYbmNHN+jTD3X8nRqo+4Qhmu6SHi3VquQENBFsZNQwBCACuowprHNSHhPBKxaBX7qOv
 KAGCmAVhK0eleElKy0sCkFghTenu1sA9AV4okL84qZ9gzaEoVkgbIbDgRbKY2MGvgKxXm+kY
 n8tmCejKoeyVcn9Xs0K5aUZiDz4Ll9VPTiXdf8YcjDgeP6/l4kHb4uSW4Aa9ds0xgt0gP1Xb
 AMwBlK19YvTDZV5u3YVoGkZhspfQqLLtBKSt3FuxTCU7hxCInQd3FHGJT/IIrvm07oDO2Y8J
 DXWHGJ9cK49bBGmK9B4ajsbe5GxtSKFccu8BciNluF+BqbrIiM0upJq5Xqj4y+Xjrpwqm4/M
 ScBsV0Po7qdeqv0pEFIXKj7IgO/d4W2bABEBAAGJA3IEGAEKACYWIQSpQNQ0mSwujpkQPVAi
 T6fnzIKmZAUCWxk1DAIbAgUJA8JnAAFACRAiT6fnzIKmZMB0IAQZAQoAHRYhBKZ2GgCcqNxn
 k0Sx9r6Fd25170XjBQJbGTUMAAoJEL6Fd25170XjDBUH/2jQ7a8g+FC2qBYxU/aCAVAVY0NE
 YuABL4LJ5+iWwmqUh0V9+lU88Cv4/G8fWwU+hBykSXhZXNQ5QJxyR7KWGy7LiPi7Cvovu+1c
 9Z9HIDNd4u7bxGKMpn19U12ATUBHAlvphzluVvXsJ23ES/F1c59d7IrgOnxqIcXxr9dcaJ2K
 k9VP3TfrjP3g98OKtSsyH0xMu0MCeyewf1piXyukFRRMKIErfThhmNnLiDbaVy6biCLx408L
 Mo4cCvEvqGKgRwyckVyo3JuhqreFeIKBOE1iHvf3x4LU8cIHdjhDP9Wf6ws1XNqIvve7oV+w
 B56YWoalm1rq00yUbs2RoGcXmtX1JQ//aR/paSuLGLIb3ecPB88rvEXPsizrhYUzbe1TTkKc
 4a4XwW4wdc6pRPVFMdd5idQOKdeBk7NdCZXNzoieFntyPpAq+DveK01xcBoXQ2UktIFIsXey
 uSNdLd5m5lf7/3f0BtaY//f9grm363NUb9KBsTSnv6Vx7Co0DWaxgC3MFSUhxzBzkJNty+2d
 10jvtwOWzUN+74uXGRYSq5WefQWqqQNnx+IDb4h81NmpIY/X0PqZrapNockj3WHvpbeVFAJ0
 9MRzYP3x8e5OuEuJfkNnAbwRGkDy98nXW6fKeemREjr8DWfXLKFWroJzkbAVmeIL0pjXATxr
 +tj5JC0uvMrrXefUhXTo0SNoTsuO/OsAKOcVsV/RHHTwCDR2e3W8mOlA3QbYXsscgjghbuLh
 J3oTRrOQa8tUXWqcd5A0+QPo5aaMHIK0UAthZsry5EmCY3BrbXUJlt+23E93hXQvfcsmfi0N
 rNh81eknLLWRYvMOsrbIqEHdZBT4FHHiGjnck6EYx/8F5BAZSodRVEAgXyC8IQJ+UVa02QM5
 D2VL8zRXZ6+wARKjgSrW+duohn535rG/ypd0ctLoXS6dDrFokwTQ2xrJiLbHp9G+noNTHSan
 ExaRzyLbvmblh3AAznb68cWmM3WVkceWACUalsoTLKF1sGrrIBj5updkKkzbKOq5gcC5AQ0E
 Wxk1NQEIAJ9B+lKxYlnKL5IehF1XJfknqsjuiRzj5vnvVrtFcPlSFL12VVFVUC2tT0A1Iuo9
 NAoZXEeuoPf1dLDyHErrWnDyn3SmDgb83eK5YS/K363RLEMOQKWcawPJGGVTIRZgUSgGusKL
 NuZqE5TCqQls0x/OPljufs4gk7E1GQEgE6M90Xbp0w/r0HB49BqjUzwByut7H2wAdiNAbJWZ
 F5GNUS2/2IbgOhOychHdqYpWTqyLgRpf+atqkmpIJwFRVhQUfwztuybgJLGJ6vmh/LyNMRr8
 J++SqkpOFMwJA81kpjuGR7moSrUIGTbDGFfjxmskQV/W/c25Xc6KaCwXah3OJ40AEQEAAYkC
 PAQYAQoAJhYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJbGTU1AhsMBQkDwmcAAAoJECJPp+fM
 gqZkPN4P/Ra4NbETHRj5/fM1fjtngt4dKeX/6McUPDIRuc58B6FuCQxtk7sX3ELs+1+w3eSV
 rHI5cOFRSdgw/iKwwBix8D4Qq0cnympZ622KJL2wpTPRLlNaFLoe5PkoORAjVxLGplvQIlhg
 miljQ3R63ty3+MZfkSVsYITlVkYlHaSwP2t8g7yTVa+q8ZAx0NT9uGWc/1Sg8j/uoPGrctml
 hFNGBTYyPq6mGW9jqaQ8en3ZmmJyw3CHwxZ5FZQ5qc55xgshKiy8jEtxh+dgB9d8zE/S/UGI
 E99N/q+kEKSgSMQMJ/CYPHQJVTi4YHh1yq/qTkHRX+ortrF5VEeDJDv+SljNStIxUdroPD29
 2ijoaMFTAU+uBtE14UP5F+LWdmRdEGS1Ah1NwooL27uAFllTDQxDhg/+LJ/TqB8ZuidOIy1B
 xVKRSg3I2m+DUTVqBy7Lixo73hnW69kSjtqCeamY/NSu6LNP+b0wAOKhwz9hBEwEHLp05+mj
 5ZFJyfGsOiNUcMoO/17FO4EBxSDP3FDLllpuzlFD7SXkfJaMWYmXIlO0jLzdfwfcnDzBbPwO
 hBM8hvtsyq8lq8vJOxv6XD6xcTtj5Az8t2JjdUX6SF9hxJpwhBU0wrCoGDkWp4Bbv6jnF7zP
 Nzftr4l8RuJoywDIiJpdaNpSlXKpj/K6KrnyAI/joYc7
Message-ID: <30a9e789-a994-48c6-625a-7ed52c2bedaa@suse.cz>
Date:   Wed, 9 Oct 2019 16:48:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191009140559.GY26530@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 10/9/19 4:05 PM, Al Viro wrote:
> 	get_mempolicy(2) and related syscalls have always passed
> 1 + number of bits in nodemask as maxnodes argument - see e.g.
> copy_nodes_to_user() and get_nodes().  Or libnuma, for the userland
> side -
> static void getpol(int *oldpolicy, struct bitmask *bmp)
> {
>         if (get_mempolicy(oldpolicy, bmp->maskp, bmp->size + 1, 0, 0) < 0)
>                 numa_error("get_mempolicy");
> }
> and similar for other syscalls.  However, the check for insufficient
> destination size in get_mempolicy(2) used to be
>         if (nmask != NULL && maxnode < MAX_NUMNODES)
>                 return -EINVAL;
> IOW, maxnode == MAX_NUMNODES (representing "MAX_NUMNODES - 1 bits")
> had been accepted.  The reason why that hadn't messed libnuma
> logics used to determine the required bitmap size is that
> MAX_NUMNODES is always a power of 2 and the loop in libnuma
> is
>                 nodemask_sz = 16;
>                 do {
>                         nodemask_sz <<= 1;
>                         mask = realloc(mask, nodemask_sz / 8);
>                         if (!mask)
>                                 return;
>                 } while (get_mempolicy(&pol, mask, nodemask_sz + 1, 0, 0) < 0 && errno == EINVAL &&
>                                 nodemask_sz < 4096*8);
> I.e. it's been passing 33, 65, 127, etc. until it got it large enough.

Sigh, it was silly of me to hope nobody is doing that [1]. I thought
libnuma was parsing /proc/self/status though, IIRC I've checked [2]

> That sidesteps the boundary case - we never try to pass exactly
> MAX_NUMNODES there.
> 
> However, that has changed recently, when get_mempolicy() switched
> to 
>         if (nmask != NULL && maxnode < nr_node_ids)
>                 return -EINVAL;
> _That_ can trigger.  Consider a box with nr_node_ids == 65.
> The first call in libnuma:set_nodemask_size() loop will
> pass 33 and fail, then we'll raise nodemask_sz to 64,
> allocate a 64bit mask and call get_mempolicy(&pol, mask, 65, 0, 0),
> which will succeed.  OK, so we decide to use 64bit bitmaps, and
> subsequent getpol() will be passing 65 to get_mempolicy(2).  Which
> is not a good idea, since kernel-side we'll get
> 	copy_nodes_to_user(nmask, 65, &nodes)
> And that will copy only 8 bytes out of kernel-side bitmap with
> 65 bits in it...
> 
> IOW, that check always should had been <=, not <; it didn't matter
> until commit 050c17f239fd ("numa: change get_mempolicy() to use
> nr_node_ids instead of MAX_NUMNODES") this year.  The fix is trivial
> - we need to make that check consistent with the code that does
> actual copyin/copyout.
> 
> Fixes: 050c17f239fd ("numa: change get_mempolicy() to use nr_node_ids instead of MAX_NUMNODES")
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

We should have reverted 050c17f239fd as it was fixing a patch in mmotm
that was ultimately discarded. It's not ideal e.g. for CRIU to determine
maxnode on old system and keep the value even on a new system with
possibly more nodes. But the commit was too quickly pushed into stables,
complicating the situation.

If we're not reverting then
Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks.

[1]
https://lore.kernel.org/linux-mm/32575d26-b141-6985-833a-12d48c0dce6a@suse.cz/
[2]
https://lore.kernel.org/linux-mm/4dab8a83-803a-56e0-6bbf-bdf581f2d1b4@suse.cz/

> ---
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 4ae967bcf954..e184df7633b0 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1561,7 +1561,7 @@ static int kernel_get_mempolicy(int __user *policy,
>  
>  	addr = untagged_addr(addr);
>  
> -	if (nmask != NULL && maxnode < nr_node_ids)
> +	if (nmask != NULL && maxnode <= nr_node_ids)
>  		return -EINVAL;
>  
>  	err = do_get_mempolicy(&pval, &nodes, addr, flags);
> 

