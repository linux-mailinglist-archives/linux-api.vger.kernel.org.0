Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C640149E82
	for <lists+linux-api@lfdr.de>; Mon, 27 Jan 2020 05:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgA0ErD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 26 Jan 2020 23:47:03 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52330 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgA0ErD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 26 Jan 2020 23:47:03 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00R4hTO1095313;
        Mon, 27 Jan 2020 04:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2019-08-05; bh=q+PUOqA16JD2tgWG90vYnwpvpwRRBkx2ddqWrELG7xo=;
 b=E1CBD7MNu1CceWb96a6teh+XzUrg5En1pzfIXil/N2GCLgFbU+rdLq+6DToPfEYMDoLR
 WyvyMnrhLDm4l61oDR0ljVHdzjrTty4xN1wJdvabHRTsc1BzAjGMvecMysmGpxKq73yX
 8edH2sPo+9sDZ8QShQRawGRBDCulohgtgZDyzCXpk6GM7bfWKC0wMkz5wrlYwup7soD5
 g2OXwx+bBvzuJ+fFNAIKuHQwJjQEh0Z2ScKtCN5KMZw5bM2ctV4HFdH6jaFoUvfwp9mt
 2srPASrgVNIRKQzONDN4cXvtqvvT4mcoh04oN/BaW0lahEWe6Rq85AMqodLPwG2gq/Zh KQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xrd3tw2hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 04:46:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00R4hVkS120927;
        Mon, 27 Jan 2020 04:46:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2xrytp6exj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 04:46:45 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00R4kcxI025620;
        Mon, 27 Jan 2020 04:46:38 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 26 Jan 2020 20:46:36 -0800
Date:   Mon, 27 Jan 2020 07:46:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Brian Geffon <bgeffon@google.com>
Cc:     kbuild-all@lists.01.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Brian Geffon <bgeffon@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>, Jesse Barnes <jsbarnes@google.com>
Subject: Re: [PATCH] mm: Add MREMAP_DONTUNMAP to mremap().
Message-ID: <20200127044625.GI1870@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123014627.71720-1-bgeffon@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001270040
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001270040
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Brian,

url:    https://github.com/0day-ci/linux/commits/Brian-Geffon/mm-Add-MREMAP_DONTUNMAP-to-mremap/20200125-013342
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 4703d9119972bf586d2cca76ec6438f819ffa30e

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
mm/mremap.c:561 mremap_to() error: potentially dereferencing uninitialized 'vma'.

# https://github.com/0day-ci/linux/commit/98663ca05501623c3da7f0f30be8ba7d632cf010
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 98663ca05501623c3da7f0f30be8ba7d632cf010
vim +/vma +561 mm/mremap.c

81909b842107ef Michel Lespinasse  2013-02-22  506  static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
72f87654c69690 Pavel Emelyanov    2017-02-22  507  		unsigned long new_addr, unsigned long new_len, bool *locked,
98663ca0550162 Brian Geffon       2020-01-22  508  		unsigned long flags, struct vm_userfaultfd_ctx *uf,
b22823719302e8 Mike Rapoport      2017-08-02  509  		struct list_head *uf_unmap_early,
897ab3e0c49e24 Mike Rapoport      2017-02-24  510  		struct list_head *uf_unmap)
ecc1a8993751de Al Viro            2009-11-24  511  {
ecc1a8993751de Al Viro            2009-11-24  512  	struct mm_struct *mm = current->mm;
ecc1a8993751de Al Viro            2009-11-24  513  	struct vm_area_struct *vma;
ecc1a8993751de Al Viro            2009-11-24  514  	unsigned long ret = -EINVAL;
ecc1a8993751de Al Viro            2009-11-24  515  	unsigned long charged = 0;
097eed103862f9 Al Viro            2009-11-24  516  	unsigned long map_flags;
ecc1a8993751de Al Viro            2009-11-24  517  
f19cb115a25f3f Alexander Kuleshov 2015-11-05  518  	if (offset_in_page(new_addr))
ecc1a8993751de Al Viro            2009-11-24  519  		goto out;
ecc1a8993751de Al Viro            2009-11-24  520  
ecc1a8993751de Al Viro            2009-11-24  521  	if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
ecc1a8993751de Al Viro            2009-11-24  522  		goto out;
ecc1a8993751de Al Viro            2009-11-24  523  
9943242ca46814 Oleg Nesterov      2015-09-04  524  	/* Ensure the old/new locations do not overlap */
9943242ca46814 Oleg Nesterov      2015-09-04  525  	if (addr + old_len > new_addr && new_addr + new_len > addr)
ecc1a8993751de Al Viro            2009-11-24  526  		goto out;
ecc1a8993751de Al Viro            2009-11-24  527  
ea2c3f6f554561 Oscar Salvador     2019-03-05  528  	/*
ea2c3f6f554561 Oscar Salvador     2019-03-05  529  	 * move_vma() need us to stay 4 maps below the threshold, otherwise
ea2c3f6f554561 Oscar Salvador     2019-03-05  530  	 * it will bail out at the very beginning.
ea2c3f6f554561 Oscar Salvador     2019-03-05  531  	 * That is a problem if we have already unmaped the regions here
ea2c3f6f554561 Oscar Salvador     2019-03-05  532  	 * (new_addr, and old_addr), because userspace will not know the
ea2c3f6f554561 Oscar Salvador     2019-03-05  533  	 * state of the vma's after it gets -ENOMEM.
ea2c3f6f554561 Oscar Salvador     2019-03-05  534  	 * So, to avoid such scenario we can pre-compute if the whole
ea2c3f6f554561 Oscar Salvador     2019-03-05  535  	 * operation has high chances to success map-wise.
ea2c3f6f554561 Oscar Salvador     2019-03-05  536  	 * Worst-scenario case is when both vma's (new_addr and old_addr) get
ea2c3f6f554561 Oscar Salvador     2019-03-05  537  	 * split in 3 before unmaping it.
ea2c3f6f554561 Oscar Salvador     2019-03-05  538  	 * That means 2 more maps (1 for each) to the ones we already hold.
ea2c3f6f554561 Oscar Salvador     2019-03-05  539  	 * Check whether current map count plus 2 still leads us to 4 maps below
ea2c3f6f554561 Oscar Salvador     2019-03-05  540  	 * the threshold, otherwise return -ENOMEM here to be more safe.
ea2c3f6f554561 Oscar Salvador     2019-03-05  541  	 */
ea2c3f6f554561 Oscar Salvador     2019-03-05  542  	if ((mm->map_count + 2) >= sysctl_max_map_count - 3)
ea2c3f6f554561 Oscar Salvador     2019-03-05  543  		return -ENOMEM;
ea2c3f6f554561 Oscar Salvador     2019-03-05  544  
b22823719302e8 Mike Rapoport      2017-08-02  545  	ret = do_munmap(mm, new_addr, new_len, uf_unmap_early);
ecc1a8993751de Al Viro            2009-11-24  546  	if (ret)
ecc1a8993751de Al Viro            2009-11-24  547  		goto out;
ecc1a8993751de Al Viro            2009-11-24  548  
ecc1a8993751de Al Viro            2009-11-24  549  	if (old_len >= new_len) {
897ab3e0c49e24 Mike Rapoport      2017-02-24  550  		ret = do_munmap(mm, addr+new_len, old_len - new_len, uf_unmap);
ecc1a8993751de Al Viro            2009-11-24  551  		if (ret && old_len != new_len)
ecc1a8993751de Al Viro            2009-11-24  552  			goto out;
ecc1a8993751de Al Viro            2009-11-24  553  		old_len = new_len;
ecc1a8993751de Al Viro            2009-11-24  554  	}
ecc1a8993751de Al Viro            2009-11-24  555  
98663ca0550162 Brian Geffon       2020-01-22  556  	/*
98663ca0550162 Brian Geffon       2020-01-22  557  	 * MREMAP_DONTUNMAP expands by old_len + (new_len - old_len), we will
98663ca0550162 Brian Geffon       2020-01-22  558  	 * check that we can expand by old_len and vma_to_resize will handle
98663ca0550162 Brian Geffon       2020-01-22  559  	 * the vma growing.
98663ca0550162 Brian Geffon       2020-01-22  560  	 */
98663ca0550162 Brian Geffon       2020-01-22 @561  	if (unlikely(flags & MREMAP_DONTUNMAP && !may_expand_vm(mm,
98663ca0550162 Brian Geffon       2020-01-22  562  				vma->vm_flags, old_len >> PAGE_SHIFT))) {
                                                                                ^^^^^^^^^^^^^

98663ca0550162 Brian Geffon       2020-01-22  563  		ret = -ENOMEM;
98663ca0550162 Brian Geffon       2020-01-22  564  		goto out;
98663ca0550162 Brian Geffon       2020-01-22  565  	}
98663ca0550162 Brian Geffon       2020-01-22  566  
ecc1a8993751de Al Viro            2009-11-24  567  	vma = vma_to_resize(addr, old_len, new_len, &charged);
                                                        ^^^^^^^^^^^^^^^^^^^^

ecc1a8993751de Al Viro            2009-11-24  568  	if (IS_ERR(vma)) {
ecc1a8993751de Al Viro            2009-11-24  569  		ret = PTR_ERR(vma);
ecc1a8993751de Al Viro            2009-11-24  570  		goto out;
ecc1a8993751de Al Viro            2009-11-24  571  	}
ecc1a8993751de Al Viro            2009-11-24  572  
097eed103862f9 Al Viro            2009-11-24  573  	map_flags = MAP_FIXED;

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
